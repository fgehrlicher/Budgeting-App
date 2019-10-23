import 'package:hunger_preventer/data/models/account_balance.dart';

class AccountBalanceSnapshot extends AccountBalance {
  final DateTime _date;

  AccountBalanceSnapshot(int balance, this._date) : super(balance);

  DateTime get date => _date;

  @override
  String toString() {
    return '${this.date.day}/${this.date.month}/${this.date.year} ${this.balance} Account Balance Snapshot';
  }
}
