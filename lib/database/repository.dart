import 'package:contacts/database/connection.dart';
import 'package:sqflite/sqflite.dart';

class CrudOperatons {
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

  //inserting data
  insertData(data) async {
    var connection = await database;
    return await connection?.insert('contacts', data);
  }

//accessing contacts table data
  returnData() async {
    var connection = await database;
    var data = await connection?.rawQuery("select * from contacts;");
    return data?.map(
      (e) {
        return e;
      },
    ).toList();
  }

  //accessing a contacts
  contactsData(id) async {
    var connection = await database;
    return connection?.query('contacts', where: 'admno=?', whereArgs: [id]);
  }

//delete a contacts
  contactsDelete(id) async {
    var connection = await database;
    return connection?.rawDelete("delete from contacts where admno='$id';");
  }

  //update a contacts
  contactsUpdate(Map data, id) async {
    var connecttion = await database;
    var name = data['name'];
    var age = data['age'];
    var admno = data['admno'];
    var photo = data['photo'];
    return connecttion?.rawUpdate(
        "update contacts set name='$name',age='$age',admno='$admno',photo='$photo' where admno='$id';");
  }
}
