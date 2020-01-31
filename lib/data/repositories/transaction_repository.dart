import 'package:unnamed_budgeting_app/data/repositories/repository.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction.dart' as model;
import 'package:sqflite/sqflite.dart';
import 'package:meta/meta.dart';

class TransactionRepository extends Repository<model.Transaction> {
  TransactionRepository({
    @required Future<Database> database,
  }) : super(
          database: database,
          tableName: model.Transaction.TABLE_NAME,
          mapperFunc: _parseQueryResult,
        );

  static model.Transaction _parseQueryResult(
    Map<String, dynamic> queryResult,
  ) =>
      model.Transaction.fromMap(queryResult);

  Future<List<model.Transaction>> getAllInRange(DateTime from,
      [DateTime until]) async {
    until ??= DateTime.now();

    return getAll(
      where: 'date > ? AND date < ?',
      whereArgs: [from.millisecondsSinceEpoch, until.millisecondsSinceEpoch],
    );
  }
}
