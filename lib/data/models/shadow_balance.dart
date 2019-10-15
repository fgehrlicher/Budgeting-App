import 'package:hunger_preventer/data/models/balance_snapshot.dart';

class ShadowAccountBalance extends AccountBalanceSnapshot {
  ShadowAccountBalance(double balance, DateTime date) : super(balance, date);

  @override
  String toString() {
    return '${this.date} ${this.balance.toStringAsFixed(2)} Shadow Account Balance';
  }
}
