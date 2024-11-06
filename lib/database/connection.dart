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
        "create table student(name text,age int,admno text PRIMARY KEY,photo text)";
    await database.execute(sql);
  }
}
