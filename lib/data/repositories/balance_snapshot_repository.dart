import 'package:hunger_preventer/domain/models/balance_snapshot.dart';
import 'package:sqflite/sqflite.dart';

class BalanceSnapshotRepository {
  Future<Database> database;

  String _tableName = AccountBalanceSnapshot.TABLE_NAME;

  BalanceSnapshotRepository(this.database);

  Future<List<AccountBalanceSnapshot>> getAllInRange(DateTime from,
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
        AccountBalanceSnapshot.fromMap(rawMap),
      ),
    );

    return list;
  }

  Future<List<AccountBalanceSnapshot>> getAll() async {
    var db = await database;
    var list = List();

    final List<Map<String, dynamic>> queryResult = await db.query(_tableName);

    queryResult.forEach(
      (rawMap) => list.add(
        AccountBalanceSnapshot.fromMap(rawMap),
      ),
    );

    return list;
  }

  void insertMultiple(List<AccountBalanceSnapshot> snapshots) async {
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

  void insertOne(AccountBalanceSnapshot snapshots) async {
    var db = await database;

    await db.insert(_tableName, snapshots.toMap());
  }
}
