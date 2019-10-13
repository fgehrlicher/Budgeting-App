import 'package:hunger_preventer/data/models/transaction.dart';
import 'package:hunger_preventer/data/models/transaction_list.dart';

class TransactionRepository {
  TransactionList get(DateTime from, [DateTime until]) {
    until ??= DateTime.now();
    var list = TransactionList();

    list
      ..add(Transaction(DateTime.parse("2020-01-01 13:00:00"), 2800))
      ..add(Transaction(DateTime.parse("2020-01-02 16:00:00"), -30.00))
      ..add(Transaction(DateTime.parse("2020-01-03 20:00:00"), -20.00))
      ..add(Transaction(DateTime.parse("2020-01-05 09:00:00"), -100.23))
      ..add(Transaction(DateTime.parse("2020-01-06 09:00:00"), 2800))
      ..add(Transaction(DateTime.parse("2020-01-07 09:00:00"), -100.23))
      ..add(Transaction(DateTime.parse("2020-01-08 09:00:00"), -100.23))
      ..add(Transaction(DateTime.parse("2020-01-09 09:00:00"), -100.23));

    return list;
  }
}
