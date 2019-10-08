import 'package:hunger_preventer/data/models/transaction.dart';
import 'package:hunger_preventer/data/models/transaction_list.dart';

class TransactionRepository {
  TransactionList get(DateTime from, [DateTime until]) {
    until ??= DateTime.now();
    var list = TransactionList();

    list.add(Transaction(DateTime.parse("2012-02-27 12:00:00"), 2800));
    list.add(Transaction(DateTime.parse("2022-02-27 12:00:00"), -30.00));
    list.add(Transaction(DateTime.parse("2019-02-27 12:00:00"), -20.00));
    list.add(Transaction(DateTime.parse("2018-02-27 12:00:00"), -100.23));

    return list;
  }
}
 