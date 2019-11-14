import 'package:hunger_preventer/domain/models/transaction_type.dart';

class Transaction {
  int _id;
  DateTime _date;
  int _amount;
  TransactionType _type;
  String _iban;
  String _bic;

  Transaction(
    this._date,
    this._amount, [
    this._id,
    this._type,
    this._iban,
    this._bic,
  ]);

  Transaction.fromMap(Map<String, dynamic> data) {
    this._date = data['date'];
    this._amount = data['amount'];
    this._id = data['id'];
    this._type = data['type'];
    this._iban = data['iban'];
    this._bic = data['bic'];
  }

  Map<String, dynamic> toMap() {
    var map = {
      'id': this.id,
      'date': this.date.millisecondsSinceEpoch,
      'amount': this.amount,
      'type': this.type,
      'iban': this.iban,
      'bic': this.bic,
    };

    map.removeWhere((key, value) => value == null);
    return map;
  }

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
}
