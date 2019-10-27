import 'package:hunger_preventer/domain/models/transaction.dart' as model;
import 'package:hunger_preventer/data/repositories/repository.dart';
import 'package:hunger_preventer/domain/models/transaction_list.dart';
import 'package:sqflite/sqflite.dart';

class TransactionRepository extends Repository {
  TransactionRepository(Database db) : super(db);

  Future<TransactionList> get(DateTime from, [DateTime until]) async {
    until ??= DateTime.now();
    var list = TransactionList();

    final List<Map<String, dynamic>> maps =
        await this.database.query('transaction');

    list.addAll(List.generate(maps.length, (i) {
      return model.Transaction(
        DateTime.fromMillisecondsSinceEpoch(maps[i]['date'] * 1000),
          maps[i]['amount']
      );
    }));
    return list;
  }
}
