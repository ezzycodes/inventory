import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'logs.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE logs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            ticketNumber TEXT,
            recipient TEXT,
            timestamp TEXT,
            products TEXT,
            signature BLOB
          )
        ''');
      },
    );
  }

  Future<void> updateStock(int productId, int newStock) async {
  final db = await database;
  await db.update(
    'products', // The table name
    {'stock': newStock},
    where: 'id = ?',
    whereArgs: [productId],
  );
}




  Future<int> insertLog(Map<String, dynamic> log) async {
    final db = await database;
    return await db.insert('logs', log);
  }

  Future<List<Map<String, dynamic>>> getLogs() async {
    final db = await database;
    return await db.query('logs', orderBy: 'timestamp DESC');
  }
}
