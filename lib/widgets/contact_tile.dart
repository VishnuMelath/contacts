import 'dart:developer';

import 'package:contacts/datamodel/contacts_model.dart';
import 'package:contacts/method_channel/call_service.dart';
import 'package:contacts/pages/contact_view.dart';
import 'package:flutter/material.dart';

Widget contactTile(BuildContext context, ContactsModel contact) {
  log(contact.numbers.toString());
  return ListTile(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContactView(contactsModel: contact),
          ));
    },
    leading: const CircleAvatar(
      backgroundColor: Colors.black26,
      child: Icon(
        Icons.person,
        color: Colors.white,
      ),
    ),
    title: Text(
      '${contact.firstName} ${contact.surname}',
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: Text(contact.numbers.first),
    trailing: IconButton(
        onPressed: () {
          CallService().makePhoneCall(contact.numbers.first, context);
        },
        icon: const Icon(Icons.phone)),
  );
}
