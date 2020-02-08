import 'package:unnamed_budgeting_app/domain/model/transaction.dart';
import 'package:meta/meta.dart';

abstract class TimeFrameEvent {}

class LoadTimeFrame extends TimeFrameEvent {
  final int loadCount;

  LoadTimeFrame({this.loadCount = 20});
}

class FetchTimeFrame extends TimeFrameEvent {
  final int fetchCount;
  final Transaction lastTransaction;

  FetchTimeFrame({@required this.lastTransaction, this.fetchCount = 20});
}

class AddTransaction extends TimeFrameEvent {
  final Transaction transaction;

  AddTransaction({@required this.transaction});
}

class UpdateTransaction extends TimeFrameEvent {
  final Transaction transaction;

  UpdateTransaction({@required this.transaction});
}

class DeleteTransaction extends TimeFrameEvent {
  final Transaction transaction;

  DeleteTransaction({@required this.transaction});
}

class RestoreTransaction extends TimeFrameEvent {
  final Transaction transaction;

  RestoreTransaction({@required this.transaction});
}
