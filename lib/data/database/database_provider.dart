import 'package:hunger_preventer/data/database/schema.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseProvider {
  static Database _database;
  static const String DATABASE_FILE_NAME = "hunger-preventer.db";

  static Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _openDatabase();
    return _database;
  }

  static Future<Database> _openDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), DATABASE_FILE_NAME),
      onCreate: _initializeDatabase,
    );
  }

  static void _initializeDatabase(Database db, int version) async {
    await db.execute(
      SchemaProvider.getDatabaseSchema(),
    );
  }
}
