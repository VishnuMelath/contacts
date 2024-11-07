import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getDatabasesPath();
    var path = join(directory, 'contacts');
    var database = await openDatabase(path, version: 1, onCreate: _createTable);
    return database;
  }

  _createTable(Database database, int version) async {
    String sql =
        "create table contacts(id text primary key,firstname text,surname text,numbers text,company text,fav text)";
    await database.execute(sql);
  }
}
