import 'package:hunger_preventer/data/database/schema.dart';
import 'package:hunger_preventer/domain/models/acount_balance.dart';
import 'package:hunger_preventer/domain/models/transaction.dart' as model;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseProvider {
  static const String DATABASE_FILE_NAME = "hunger-preventer.db";
  static Future<Database> _database = _openDatabase();

  static Future<Database> get database => _database;

  static Future<Database> _openDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), DATABASE_FILE_NAME),
      version: 1,
      onCreate: _initializeDatabase,
    );
  }

  static void _initializeDatabase(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute(
      SchemaProvider.getSchema(
        model.Transaction(),
      ),
    );
    batch.execute(
      SchemaProvider.getSchema(
        AccountBalance(),
      ),
    );
    await batch.commit(noResult: true);
  }
}
