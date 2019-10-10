import 'package:scoped_model/scoped_model.dart';

class BalanceSnapshot extends Model {
  final double _balance;
  final DateTime _date;

  BalanceSnapshot(
    this._balance,
    this._date,
  );

  @override
  String toString() {
    return this._balance.toString() + " €";
  }
}
