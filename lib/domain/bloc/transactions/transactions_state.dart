import 'package:unnamed_budgeting_app/domain/model/transaction.dart';
import 'package:unnamed_budgeting_app/domain/model/transaction_list.dart';
import 'package:meta/meta.dart';

abstract class TransactionsState {}

class NoTimeFrame extends TransactionsState {}

class TimeFrameInitialLoading extends TransactionsState {}

class TimeFrameLoading extends TransactionsState {}

class TimeFrameLoaded extends TransactionsState {
  final TransactionList transactionList;

  TimeFrameLoaded({@required this.transactionList});
}

class TimeFrameFetched extends TransactionsState {
  final TransactionList transactionList;

  TimeFrameFetched({@required this.transactionList});
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
