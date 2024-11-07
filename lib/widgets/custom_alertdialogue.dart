// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:contacts/database/repository.dart';
import 'package:contacts/datamodel/contacts_model.dart';
import 'package:contacts/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';

class DeleteContactDialog extends StatelessWidget {
  final String contactName;
  final VoidCallback onDelete;

  const DeleteContactDialog({
    super.key,
    required this.contactName,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Delete contact',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Text(
        'Are you sure you want to remove $contactName from your contacts?',
        style: const TextStyle(fontSize: 14),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'NO',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            onDelete();
            Navigator.of(context).pop();
          },
          child: const Text(
            'YES',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

showDeleteConfirmation(BuildContext context, ContactsModel contact) {
  showDialog(
    context: context,
    builder: (context) => DeleteContactDialog(
      contactName: '${contact.firstName} ${contact.surname}',
      onDelete: () {
        CrudOperatons().contactsDelete(contact.id).then(
          (value) {
            showContactDeletedSnackbar(context, contact.firstName);
            Navigator.pop(context);
          },
        );
        log('Deleting contact: ${contact.firstName}');
      },
    ),
  );
}
