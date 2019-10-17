import 'package:hunger_preventer/data/models/transaction_type.dart';

class Transaction {
  final DateTime _date;
  final double _amount;
  final TransactionType _type;
  final String _iban;
  final String _bic;

  Transaction(
    this._date,
    this._amount, [
    this._type,
    this._iban,
    this._bic,
  ]);

  double get amount => _amount;

  DateTime get date => _date;

  @override
  String toString() {
    return '${this.date.day}/${this.date.month}/${this.date.year} ${this.amount.toStringAsFixed(2)} Transaction';
  }
}
