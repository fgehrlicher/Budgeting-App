import 'package:hunger_preventer/data/models/transaction.dart';
import 'package:hunger_preventer/data/models/transaction_list.dart';

class TransactionRepository {
  TransactionList get(DateTime from, [DateTime until]) {
    until ??= DateTime.now();
    var list = TransactionList();

    list
      ..add(Transaction(DateTime.parse("2012-01-07 13:00:00"), 2800))
      ..add(Transaction(DateTime.parse("2022-08-12 16:00:00"), -30.00))
      ..add(Transaction(DateTime.parse("2019-01-06 20:00:00"), -20.00))
      ..add(Transaction(DateTime.parse("2018-12-28 09:00:00"), -100.23));

    return list;
  }
}
