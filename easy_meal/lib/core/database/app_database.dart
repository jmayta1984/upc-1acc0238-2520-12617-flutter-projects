import 'package:easy_meal/core/constants/database_constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase _instance = AppDatabase._();

  factory AppDatabase() => _instance;

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database as Database;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, DatabaseConstants.databaseName);

    return await openDatabase(
      path,
      version: DatabaseConstants.databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE ${DatabaseConstants.mealsTable} (
            id TEXT PRIMARY KEY,
            name TEXT,
            poster_path TEXT
          )
        ''');
      },
    );
  }
}
