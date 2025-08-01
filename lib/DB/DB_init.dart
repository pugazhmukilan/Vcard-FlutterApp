import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> initDatabase() async {
  final dataPath = await getDatabasesPath();
  final path = join(dataPath, 'my_db.db');
  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await db.execute('CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,profession TEXT,phonenumber TEXT, email TEXT,gender TEXT)');
    },
  );
}
