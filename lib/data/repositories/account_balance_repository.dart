import 'package:unnamed_budgeting_app/data/repositories/repository.dart';
import 'package:unnamed_budgeting_app/domain/models/acount_balance.dart';
import 'package:sqflite/sqflite.dart';
import 'package:meta/meta.dart';

class AccountBalanceRepository extends Repository<AccountBalance> {
  AccountBalanceRepository({
    @required Future<Database> database,
  }) : super(
          database: database,
          tableName: AccountBalance.TABLE_NAME,
          mapperFunc: _parseQueryResult,
        );

  static AccountBalance _parseQueryResult(
    Map<String, dynamic> queryResult,
  ) =>
      AccountBalance.fromMap(queryResult);

  Future<List<AccountBalance>> getAllInRange(DateTime from,
      [DateTime until]) async {
    until ??= DateTime.now();

    return getAll(
      where: 'date > ? AND date < ?',
      whereArgs: [from.millisecondsSinceEpoch, until.millisecondsSinceEpoch],
    );
  }
}
