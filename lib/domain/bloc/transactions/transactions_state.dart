import 'package:unnamed_budgeting_app/domain/models/transaction.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction_list.dart';

abstract class TransactionsState {}

class TransactionsEmpty extends TransactionsState {}

class TransactionsInitialLoading extends TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsLoaded extends TransactionsState {
  final TransactionList transactions;

  TransactionsLoaded(this.transactions);
}

class TransactionDeleted extends TransactionsState {
  final Transaction transaction;

  TransactionDeleted(this.transaction);
}

class TransactionRestored extends TransactionsState {
  final Transaction transaction;

  TransactionRestored(this.transaction);
}

class TransactionAdded extends TransactionsState {
  final Transaction transaction;

  TransactionAdded(this.transaction);
}

class TransactionFetched extends TransactionsState {
  final TransactionList transactions;

  TransactionFetched(this.transactions);
}
