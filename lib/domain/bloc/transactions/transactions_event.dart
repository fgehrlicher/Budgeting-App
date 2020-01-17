import 'package:unnamed_budgeting_app/domain/models/transaction.dart';

abstract class TransactionsEvent {}

class LoadTransactions extends TransactionsEvent {}

class AddTransaction extends TransactionsEvent {
  final Transaction transaction;

  AddTransaction(this.transaction);
}

class UpdateTransaction extends TransactionsEvent {
  final Transaction transaction;

  UpdateTransaction(this.transaction);
}

class DeleteTransaction extends TransactionsEvent {
  final Transaction transaction;

  DeleteTransaction(this.transaction);
}

class RestoreTransaction extends TransactionsEvent {
  final Transaction transaction;

  RestoreTransaction(this.transaction);
}

class FetchTransactions extends TransactionsEvent {
  final int fetchCount;
  final Transaction lastTransaction;

  FetchTransactions(this.fetchCount, this.lastTransaction);
}
