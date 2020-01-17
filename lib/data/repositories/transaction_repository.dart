import 'package:unnamed_budgeting_app/domain/models/transaction_list.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction.dart' as model;
import 'package:sqflite/sqflite.dart';

class TransactionRepository {
  Future<Database> database;

  String _tableName = model.Transaction.TABLE_NAME;

  TransactionRepository(this.database);

  Future<TransactionList> getAllInRange(DateTime from, [DateTime until]) async {
    until ??= DateTime.now();
    var db = await database;

    final List<Map<String, dynamic>> queryResult = await db.query(
      _tableName,
      where: 'date > ? AND date < ?',
      whereArgs: [from.millisecondsSinceEpoch, until.millisecondsSinceEpoch],
    );

    return TransactionList.fromMap(queryResult);
  }

  Future<TransactionList> getAll({
    model.Transaction after,
    int limit = 20,
  }) async {
    var db = await database;
    final List<Map<String, dynamic>> queryResult = await db.query(
      _tableName,
      limit: limit,
      offset: after?.id,
    );

    return TransactionList.fromMap(queryResult);
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

  void insert(model.Transaction transaction) async {
    var db = await database;

    await db.insert(
      _tableName,
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void delete(model.Transaction transaction) async {
    var db = await database;

    await db.delete(
      _tableName,
      where: "${model.Transaction.ID_NAME} = ?",
      whereArgs: [transaction.id],
    );
  }
}
