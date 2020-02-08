import 'package:unnamed_budgeting_app/domain/model/acount_balance.dart';
import 'package:unnamed_budgeting_app/domain/model/transaction.dart';

class TimeFrame {
  int offset;
  List<Transaction> transactions;
  AccountBalance start;
  AccountBalance end;

  TimeFrame({this.offset, this.transactions, this.start, this.end});
}
