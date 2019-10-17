import 'package:hunger_preventer/data/models/transaction_list.dart';

class TransactionRepository {
  TransactionList get(DateTime from, [DateTime until]) {
    until ??= DateTime.now();
    var list = TransactionList();
    return list;
  }
}
