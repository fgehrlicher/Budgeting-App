import 'package:unnamed_budgeting_app/domain/models/transaction.dart';
import 'package:meta/meta.dart';

abstract class TransactionsEvent {}

class LoadTransactions extends TransactionsEvent {
  final int loadCount;

  LoadTransactions({this.loadCount = 20});
}

class AddTransaction extends TransactionsEvent {
  final Transaction transaction;

  AddTransaction({@required this.transaction});
}

class UpdateTransaction extends TransactionsEvent {
  final Transaction transaction;

  UpdateTransaction({@required this.transaction});
}

class DeleteTransaction extends TransactionsEvent {
  final Transaction transaction;

  DeleteTransaction({@required this.transaction});
}

class RestoreTransaction extends TransactionsEvent {
  final Transaction transaction;

  RestoreTransaction({@required this.transaction});
}

class FetchTransactions extends TransactionsEvent {
  final int fetchCount;
  final Transaction lastTransaction;

  FetchTransactions({@required this.lastTransaction, this.fetchCount = 20});
}
