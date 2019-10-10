class BalanceSnapshot {
  final double _balance;
  final DateTime _date;

  BalanceSnapshot(
    this._balance,
    this._date,
  );

  DateTime get date => _date;

  @override
  String toString() {
    return this._balance.toString() + " €";
  }
}
