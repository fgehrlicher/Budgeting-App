import 'package:hunger_preventer/data/models/balance.dart';

class BalanceSnapshot extends Balance {
  final DateTime _date;

  BalanceSnapshot(double balance, this._date) : super(balance);

  DateTime get date => _date;

  @override
  String toString() {
    return 'Balance: ${this.date} ${this.balance.toStringAsFixed(2)}';
  }
}