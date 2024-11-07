import 'dart:developer';

import 'package:contacts/database/repository.dart';
import 'package:contacts/datamodel/contacts_model.dart';
import 'package:contacts/pages/add_update_page.dart';
import 'package:contacts/widgets/custom_alertdialogue.dart';
import 'package:flutter/material.dart';

class ContactView extends StatefulWidget {
  final ContactsModel contactsModel;
  const ContactView({super.key, required this.contactsModel});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  late ContactsModel contactsModel;
  @override
  void initState() {
    contactsModel = widget.contactsModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: [
          IconButton(
              onPressed: () async {
                contactsModel.fav = !contactsModel.fav;
                await CrudOperatons().contactsUpdate(contactsModel);
                log('updated');
                setState(() {});
              },
              icon: Icon(
                  contactsModel.fav ? Icons.favorite : Icons.favorite_border)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddUpdateContactPage(
                        contactsModel: contactsModel,
                      ),
                    )).then(
                  (value) {
                    setState(() {
                      contactsModel = value;
                    });
                  },
                );
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                showDeleteConfirmation(context, contactsModel);
              },
              icon: const Icon(Icons.delete)),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.black26,
            child: Icon(
              Icons.person,
              size: 50,
              color: Colors.white,
            ),
          ),
          Center(
              child: Text(
            '${contactsModel.firstName} ${contactsModel.surname}',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          )),
          Center(
            child: Text(contactsModel.company),
          ),
          ...contactsModel.numbers.map(
            (e) => ListTile(
              title: Text(
                e,
                style: const TextStyle(fontSize: 18),
              ),
              trailing: IconButton(
                  onPressed: () {
                    //todo call fn
                  },
                  icon: const Icon(Icons.phone)),
            ),
          ),
        ],
      ),
    );
  }
}
