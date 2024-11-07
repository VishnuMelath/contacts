import 'dart:developer';

import 'package:contacts/database/connection.dart';
import 'package:contacts/datamodel/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class CrudOperatons extends ChangeNotifier {
  static ValueNotifier<List<ContactsModel>> contacts = ValueNotifier([]);
  late DatabaseConnection _databaseConnection;
  CrudOperatons() {
    _databaseConnection = DatabaseConnection();
  }
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  //inserting contact
  Future addContact(ContactsModel data) async {
    var connection = await database;
    await connection?.insert('contacts', data.toMap());
    await loadContact();
  }

//accessing contacts table data
  Future<void> loadContact() async {
    var connection = await database;
    var data = await connection?.rawQuery("select * from contacts;");
    log(data.toString());
    var list = data?.map(
          (e) {
            return ContactsModel.fromMap(e);
          },
        ).toList() ??
        [];
    sortByFirstName(list);
    contacts.value = list;
    notifyListeners();
  }

  //accessing a contact
  contactsData(id) async {
    var connection = await database;
    return connection?.query('contacts', where: 'id=?', whereArgs: [id]);
  }

//delete a contact
  Future contactsDelete(id) async {
    var connection = await database;
    await connection?.rawDelete("delete from contacts where id='$id';");
    await loadContact();
  }

  //update a contacts
  Future contactsUpdate(ContactsModel data) async {
    log(data.toMap().toString());
    var connection = await database;
    await connection
        ?.update('contacts', data.toMap(), where: 'id=?', whereArgs: [data.id]);
    await loadContact();
  }

  void sortByFirstName(List<ContactsModel> people, {bool ascending = true}) {
    people.sort((a, b) => ascending
        ? a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase())
        : b.firstName.toLowerCase().compareTo(a.firstName.toLowerCase()));
  }
}
