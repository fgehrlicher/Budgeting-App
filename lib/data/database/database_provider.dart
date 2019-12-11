import 'package:unnamed_budgeting_app/data/database/schema.dart';
import 'package:unnamed_budgeting_app/domain/models/acount_balance.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction.dart' as model;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseProvider {
  static const String DATABASE_FILE_NAME = "unnamed-budgeting-app.db";
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
