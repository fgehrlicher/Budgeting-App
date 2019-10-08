import 'package:hunger_preventer/data/models/transaction.dart';
import 'package:hunger_preventer/data/models/transaction_list.dart';

class TransactionRepository {
  TransactionList get(DateTime from, [DateTime until]) {
    until ??= DateTime.now();
    var list = TransactionList();

    list.add(Transaction(DateTime.now(), 2800));
    list.add(Transaction(DateTime.now(), -100.23));
    list.add(Transaction(DateTime.now(), -20.00));
    list.add(Transaction(DateTime.now(), -30.00));

    return list;
  }
}
 