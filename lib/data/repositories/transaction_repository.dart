import 'package:hunger_preventer/data/database/database_provider.dart';
import 'package:hunger_preventer/domain/models/transaction.dart' as model;
import 'package:hunger_preventer/domain/models/transaction_list.dart';
import 'package:sqflite/sqflite.dart';

class TransactionRepository {
  TransactionRepository(Database db);

  Future<TransactionList> get(DateTime from, [DateTime until]) async {
    until ??= DateTime.now();
    var list = TransactionList();
    var database = await DatabaseProvider.database;

    final List<Map<String, dynamic>> maps = await database.query('transaction');

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
    var database = await DatabaseProvider.database;

    final List<Map<String, dynamic>> maps = await database.query('transaction');

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
