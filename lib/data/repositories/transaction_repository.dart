import 'package:hunger_preventer/data/database/schema.dart';
import 'package:hunger_preventer/domain/models/transaction_list.dart';
import 'package:hunger_preventer/domain/models/transaction.dart' as model;
import 'package:sqflite/sqflite.dart';

class TransactionRepository {
  Future<Database> database;

  String _tableName = SchemaProvider.TRANSACTION_TABLE_NAME;

  TransactionRepository(this.database);

  Future<TransactionList> getAllInRange(DateTime from, [DateTime until]) async {
    until ??= DateTime.now();
    var db = await database;

    final List<Map<String, dynamic>> queryResult = await db.query(
      _tableName,
      where: 'date > ? AND date < ?',
      whereArgs: [from.millisecondsSinceEpoch, until.millisecondsSinceEpoch],
    );

    return TransactionList.fromQueryResult(queryResult);
  }

  Future<TransactionList> getAll() async {
    var db = await database;

    final List<Map<String, dynamic>> queryResult =
        await db.query(_tableName);

    return TransactionList.fromQueryResult(queryResult);
  }

  void insertMultiple(TransactionList transactions) async {
    var db = await database;
    var batch = db.batch();

    for (var i = 0; i < transactions.length; i++) {
      batch.insert(
        _tableName,
        transactions[i].toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  void insertOne(model.Transaction transaction) async {
    var db = await database;

    await db.insert(_tableName, transaction.toMap());
  }
}
