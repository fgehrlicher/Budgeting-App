import 'package:sqflite/sqflite.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction_category.dart';

class TransactionCategoryRepository {
  Future<Database> database;

  String _tableName = TransactionCategory.TABLE_NAME;

  TransactionCategoryRepository(this.database);

  List<TransactionCategory> _parseQueryResult(
      List<Map<String, dynamic>> queryResult) {
    var list = List();
    queryResult.forEach(
      (rawMap) => list.add(
        TransactionCategory.fromMap(rawMap),
      ),
    );

    return list;
  }

  Future<List<TransactionCategory>> getAll() async {
    var db = await database;

    final List<Map<String, dynamic>> queryResult = await db.query(_tableName);

    return _parseQueryResult(queryResult);
  }

  Future<TransactionCategory> get(int id) async {
    var db = await database;

    final List<Map<String, dynamic>> queryResult = await db.query(
      _tableName,
      where: "${TransactionCategory.ID_NAME} = ?",
      whereArgs: [id],
    );

    var parsedResult = _parseQueryResult(queryResult);
    return parsedResult.length > 0 ? parsedResult[0] : null;
  }

  void insertMultiple(List<TransactionCategory> transactionCategories) async {
    var db = await database;
    var batch = db.batch();

    transactionCategories.forEach((transactionCategory) {
      batch.insert(
        _tableName,
        transactionCategory.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });

    await batch.commit(noResult: true);
  }

  void insert(TransactionCategory transactionCategory) async {
    var db = await database;

    await db.insert(
      _tableName,
      transactionCategory.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void delete(TransactionCategory transactionCategory) async {
    var db = await database;

    await db.delete(
      _tableName,
      where: "${TransactionCategory.ID_NAME} = ?",
      whereArgs: [transactionCategory.id],
    );
  }
}
