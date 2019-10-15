import 'package:hunger_preventer/data/models/balance_snapshot.dart';

class ShadowBalance extends BalanceSnapshot {
  ShadowBalance(double balance, DateTime date) : super(balance, date);

  @override
  String toString() {
    return 'Shadow Balance: ${this.date} ${this.balance.toStringAsFixed(2)}';
  }
}
