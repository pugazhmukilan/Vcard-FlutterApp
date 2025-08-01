import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


Future<Database> initDatabase() async {
  // Get the default databases location.
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, 'cards_db.db');

  // Open the database, creating table(s) if they do not exist.
  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,profession TEXT,phonenumber TEXT, email TEXT,gender TEXT)'
      );
    },
  );
}
