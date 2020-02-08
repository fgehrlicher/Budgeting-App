import 'package:unnamed_budgeting_app/domain/model/time_frame.dart';
import 'package:unnamed_budgeting_app/domain/model/transaction.dart';
import 'package:unnamed_budgeting_app/domain/model/transaction_list.dart';
import 'package:meta/meta.dart';

abstract class TimeFrameState {}

class NoTimeFrame extends TimeFrameState {}

class TimeFrameInitialLoading extends TimeFrameState {}

class TimeFrameLoading extends TimeFrameState {}

class TimeFramesLoaded extends TimeFrameState {
  final List<TimeFrame> timeFrames;

  TimeFramesLoaded({@required this.timeFrames});
}

class TimeFramesFetched extends TimeFrameState {
  final List<TimeFrame> timeFrames;

  TimeFramesFetched({@required this.timeFrames});
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
