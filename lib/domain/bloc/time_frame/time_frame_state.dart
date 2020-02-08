import 'package:unnamed_budgeting_app/domain/model/transaction.dart';
import 'package:unnamed_budgeting_app/domain/model/transaction_list.dart';
import 'package:meta/meta.dart';

abstract class TimeFrameState {}

class NoTimeFrame extends TimeFrameState {}

class TimeFrameInitialLoading extends TimeFrameState {}

class TimeFrameLoading extends TimeFrameState {}

class TimeFrameLoaded extends TimeFrameState {
  final TransactionList transactionList;

  TimeFrameLoaded({@required this.transactionList});
}

class TimeFrameFetched extends TimeFrameState {
  final TransactionList transactionList;

  TimeFrameFetched({@required this.transactionList});
}

class TransactionDeleted extends TimeFrameState {
  final Transaction transaction;

  TransactionDeleted({@required this.transaction});
}

class TransactionRestored extends TimeFrameState {
  final Transaction transaction;

  TransactionRestored({@required this.transaction});
}

class TransactionAdded extends TimeFrameState {
  final Transaction transaction;

  TransactionAdded({@required this.transaction});
}
