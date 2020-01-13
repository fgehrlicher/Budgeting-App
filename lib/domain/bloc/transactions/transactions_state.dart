import 'package:unnamed_budgeting_app/domain/models/transaction.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction_list.dart';

abstract class TransactionsState {
  const TransactionsState();
}

class TransactionsEmpty extends TransactionsState {}

class TransactionsInitialLoading extends TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsLoaded extends TransactionsState {
  final TransactionList transactions;

  const TransactionsLoaded(this.transactions);
}

class TransactionsDeleted extends TransactionsState {
  final Transaction transaction;

  const TransactionsDeleted(this.transaction);
}
