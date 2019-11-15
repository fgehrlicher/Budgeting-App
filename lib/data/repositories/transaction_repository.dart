import 'package:hunger_preventer/data/database/schema.dart';
import 'package:hunger_preventer/domain/models/transaction_list.dart';
import 'package:sqflite/sqflite.dart';

class TransactionRepository {
  Future<Database> database;

  TransactionRepository(this.database);

  Future<TransactionList> getAllInRange(DateTime from, [DateTime until]) async {
    until ??= DateTime.now();
    var db = await database;

    final List<Map<String, dynamic>> queryResult =
        await db.query(SchemaProvider.TRANSACTION_TABLE_NAME);

    return TransactionList.fromQueryResult(queryResult);
  }

  Future<TransactionList> getAll() async {
    var db = await database;

    final List<Map<String, dynamic>> queryResult =
        await db.query(SchemaProvider.TRANSACTION_TABLE_NAME);

    return TransactionList.fromQueryResult(queryResult);
  }

  void insert(TransactionList transactions) async {
    var db = await database;
    var batch = db.batch();

    for (var i = 0; i < transactions.length; i++) {
      batch.insert(
        SchemaProvider.TRANSACTION_TABLE_NAME,
        transactions[i].toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }
}
