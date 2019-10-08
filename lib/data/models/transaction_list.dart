import 'package:hunger_preventer/data/models/transaction.dart';
import 'package:quiver/collection.dart';

class TransactionList extends DelegatingList<Transaction> {
  final List<Transaction> _transactions = [];

  List<Transaction> get delegate => _transactions;
}
