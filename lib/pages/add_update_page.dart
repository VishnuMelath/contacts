// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:contacts/database/repository.dart';
import 'package:contacts/datamodel/contacts_model.dart';
import 'package:contacts/widgets/custom_button.dart';
import 'package:contacts/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class AddUpdateContactPage extends StatefulWidget {
  final ContactsModel? contactsModel;
  const AddUpdateContactPage({super.key, this.contactsModel});

  @override
  State<AddUpdateContactPage> createState() => _AddUpdateContactPageState();
}

class _AddUpdateContactPageState extends State<AddUpdateContactPage> {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _mobileFields = [];
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _surnameController =
      TextEditingController(text: '');
  final TextEditingController _companyController =
      TextEditingController(text: '');

  @override
  void initState() {
    if (widget.contactsModel != null) {
      _firstNameController.text = widget.contactsModel!.firstName;
      _surnameController.text = widget.contactsModel!.surname;
      _companyController.text = widget.contactsModel!.company;
      _mobileFields.addAll(widget.contactsModel!.numbers.map(
        (e) {
          return {
            'controller': TextEditingController(text: e.split(' ')[1]),
            'countryCode': e.split(' ').first,
          };
        },
      ));
    } else {
      _addMobileField();
    }
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _surnameController.dispose();
    _companyController.dispose();
    for (var field in _mobileFields) {
      field['controller'].dispose();
    }
    super.dispose();
  }

  void _addMobileField() {
    setState(() {
      _mobileFields.add({
        'controller': TextEditingController(),
        'countryCode': '+91',
      });
    });
  }

  void _removeMobileField(int index) {
    setState(() {
      _mobileFields[index]['controller'].dispose();
      _mobileFields.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
        title: Text(
            widget.contactsModel == null ? 'Add Contact' : 'Update Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // First Name Field
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Surname Field
              TextFormField(
                controller: _surnameController,
                decoration: const InputDecoration(
                  labelText: 'Surname',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Mobile Number Fields with Country Code Picker
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Mobile Numbers',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ..._mobileFields.asMap().entries.map((entry) {
                    int index = entry.key;
                    TextEditingController controller =
                        entry.value['controller'];
                    String countryCode = entry.value['countryCode'];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          CountryCodePicker(
                            initialSelection: countryCode,
                            showFlag: true,
                            onChanged: (country) {
                              setState(() {
                                _mobileFields[index]['countryCode'] =
                                    country.dialCode!;
                              });
                            },
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: controller,
                              decoration: const InputDecoration(
                                labelText: 'Mobile Number',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a mobile number';
                                }
                                return null;
                              },
                            ),
                          ),
                          if (index > 0)
                            IconButton(
                              icon: const Icon(Icons.remove_circle,
                                  color: Colors.red),
                              onPressed: () => _removeMobileField(index),
                            ),
                        ],
                      ),
                    );
                  }),
                  TextButton.icon(
                    onPressed: _addMobileField,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Mobile Number'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Company Field
              TextFormField(
                controller: _companyController,
                decoration: const InputDecoration(
                  labelText: 'Company',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              CustomSaveButton(
                onSave: () {
                  if (_formKey.currentState!.validate()) {
                    List<String> numbers = [];
                    for (var element in _mobileFields) {
                      numbers.add(element['countryCode'] +
                          ' ' +
                          element['controller'].text);
                    }
                    var contact = ContactsModel(
                        id: widget.contactsModel == null
                            ? DateTime.now().toString()
                            : widget.contactsModel!.id,
                        firstName: _firstNameController.text,
                        surname: _surnameController.text,
                        numbers: numbers,
                        fav: widget.contactsModel?.fav ?? false,
                        company: _companyController.text);
                    widget.contactsModel == null
                        ? CrudOperatons().addContact(contact).then(
                            (value) {
                              log(value.toString());
                              showContactAddedSnackbar(
                                context,
                                _firstNameController.text,
                              );
                              Navigator.pop(context);
                            },
                          )
                        : CrudOperatons().contactsUpdate(contact).then(
                            (value) {
                              log(value.toString());
                              showContactAddedSnackbar(
                                  context, _firstNameController.text, false);
                              Navigator.pop(context, contact);
                            },
                          );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
