class Transaction {
  final DateTime _date;
  final double _amount;

  Transaction(
    this._date,
    this._amount,
  );

  double get amount => _amount;

  DateTime get date => _date;

  @override
  String toString() {
    return '${this.date.day}/${this.date.month}/${this.date.year} ${this.amount.toStringAsFixed(2)} Transaction';
  }
}
