class Transaction {
  final DateTime _time;
  final double _amount;

  Transaction(this._time, this._amount);

  double get amount => _amount;

  DateTime get time => _time;
}
