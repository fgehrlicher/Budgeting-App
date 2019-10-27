import 'package:hunger_preventer/domain/models/transaction_type.dart';

class Transaction {
  final int _id;
  final DateTime _date;
  final int _amount;
  final TransactionType _type;
  final String _iban;
  final String _bic;

  Transaction(
    this._date,
    this._amount, [
    this._id,
    this._type,
    this._iban,
    this._bic,
  ]);

  int get id => _id;

  int get amount => _amount;

  DateTime get date => _date;

  TransactionType get type => _type;

  String get iban => _iban;

  String get bic => _bic;

  @override
  String toString() {
    return '${this.date.day}/${this.date.month}/${this.date.year} ${this.amount} Transaction';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'date': this.date,
      'amount': this.amount,
      'type': this.type,
      'iban': this.iban,
      'bic': this.bic,
    };
  }
}
