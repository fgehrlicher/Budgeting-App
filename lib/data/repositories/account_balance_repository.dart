import 'package:hunger_preventer/domain/models/acount_balance.dart';
import 'package:sqflite/sqflite.dart';

class AccountBalanceRepository {
  Future<Database> database;

  String _tableName = AccountBalance.TABLE_NAME;

  AccountBalanceRepository(this.database);

  Future<List<AccountBalance>> getAllInRange(DateTime from,
      [DateTime until]) async {
    until ??= DateTime.now();
    var db = await database;
    var list = List();

    final List<Map<String, dynamic>> queryResult = await db.query(
      _tableName,
      where: 'date > ? AND date < ?',
      whereArgs: [from.millisecondsSinceEpoch, until.millisecondsSinceEpoch],
    );

    queryResult.forEach(
      (rawMap) => list.add(
        AccountBalance.fromMap(rawMap),
      ),
    );

    return list;
  }

  Future<List<AccountBalance>> getAll() async {
    var db = await database;
    var list = List();

    final List<Map<String, dynamic>> queryResult = await db.query(_tableName);

    queryResult.forEach(
      (rawMap) => list.add(
        AccountBalance.fromMap(rawMap),
      ),
    );

    return list;
  }

  void insertMultiple(List<AccountBalance> snapshots) async {
    var db = await database;
    var batch = db.batch();

    snapshots.forEach((snapshots) {
      batch.insert(
        _tableName,
        snapshots.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });

    await batch.commit(noResult: true);
  }

  void insertOne(AccountBalance snapshots) async {
    var db = await database;

    await db.insert(_tableName, snapshots.toMap());
  }
}
