import 'package:hunger_preventer/data/database/schema.dart';
import 'package:hunger_preventer/domain/models/transaction.dart' as model;
import 'package:hunger_preventer/domain/models/transaction_list.dart';
import 'package:sqflite/sqflite.dart';

class TransactionRepository {
  Future<Database> database;

  TransactionRepository(this.database);

  Future<TransactionList> getAllInRange(DateTime from, [DateTime until]) async {
    until ??= DateTime.now();
    var db = await database;
    var list = TransactionList();

    final List<Map<String, dynamic>> maps =
        await db.query(SchemaProvider.TRANSACTION_TABLE_NAME);

    list.addAll(
      List.generate(maps.length, (i) {
        return model.Transaction(
            DateTime.fromMillisecondsSinceEpoch(maps[i]['date'] * 1000),
            maps[i]['amount']);
      }),
    );
    return list;
  }

  Future<TransactionList> getAll() async {
    var list = TransactionList();
    var db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(SchemaProvider.TRANSACTION_TABLE_NAME);

    list.addAll(
      List.generate(maps.length, (i) {
        return model.Transaction(
            DateTime.fromMillisecondsSinceEpoch(maps[i]['date'] * 1000),
            maps[i]['amount']);
      }),
    );
    return list;
  }
}
