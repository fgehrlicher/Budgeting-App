class Transaction {
  DateTime _time;
  double _amount;

  Transaction(this._time, this._amount);

  double get amount => _amount;

  DateTime get time => _time;
}
