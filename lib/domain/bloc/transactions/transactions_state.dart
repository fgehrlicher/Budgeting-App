import 'package:unnamed_budgeting_app/domain/models/transaction.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction_list.dart';
import 'package:meta/meta.dart';

abstract class TransactionsState {}

class TransactionsEmpty extends TransactionsState {}

class TransactionsInitialLoading extends TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsLoaded extends TransactionsState {
  final TransactionList transactionList;

  TransactionsLoaded({@required this.transactionList});
}

class TransactionDeleted extends TransactionsState {
  final Transaction transaction;

  TransactionDeleted({@required this.transaction});
}

class TransactionRestored extends TransactionsState {
  final Transaction transaction;

  TransactionRestored({@required this.transaction});
}

class TransactionAdded extends TransactionsState {
  final Transaction transaction;

  TransactionAdded({@required this.transaction});
}

class TransactionFetched extends TransactionsState {
  final TransactionList transactionList;

  TransactionFetched({@required this.transactionList});
}
