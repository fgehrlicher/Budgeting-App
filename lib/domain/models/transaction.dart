import 'package:hunger_preventer/data/orm/orm_config.dart';
import 'package:hunger_preventer/data/orm/field_type.dart';

enum TransactionType {
  CREDIT_CARD,
  BANK_TRANSFER,
  DIRECT_DEBIT,
}

class Transaction {
  static const String TABLE_NAME = "usertransaction";

  @OrmConfig(fieldName: 'id', fieldType: FieldType.PRIMARY_KEY)
  int _id;

  @OrmConfig(fieldName: 'date', fieldType: FieldType.DATE)
  DateTime _date;

  @OrmConfig(fieldName: 'amount', fieldType: FieldType.INT)
  int _amount;

  @OrmConfig(fieldName: 'transaction_type', fieldType: FieldType.INT)
  TransactionType _type;

  @OrmConfig(fieldName: 'iban', fieldType: FieldType.INT)
  String _iban;

  @OrmConfig(fieldName: 'bic', fieldType: FieldType.INT)
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
    this._date = DateTime.fromMillisecondsSinceEpoch(data['date']);
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
}
