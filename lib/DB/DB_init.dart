import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  // Private constructor
  DatabaseHelper._internal();

  // Static getter to access the singleton instance
  static DatabaseHelper getInstance() => _instance;

  // Private database object
  static Database? _database;

  // Private getter to initialize the DB if null
  Future<Database> _getDatabase() async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // DB initialization
  Future<Database> _initDB() async {
    final dataPath = await getDatabasesPath();
    final path = join(dataPath, 'my_db.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // DB creation
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        profession TEXT,
        phonenumber TEXT,
        email TEXT,
        gender TEXT
      )
    ''');
  }

  // Insert user
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await _getDatabase();
    return await db.insert('users', user);
  }

  // Get all users
  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await _getDatabase();

    //return in decending order by id
    return await db.query('users',orderBy: 'id DESC');
  }

  // Delete user by ID
  Future<int> deleteUser(int id) async {
    final db = await _getDatabase();
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
