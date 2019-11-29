import 'package:hunger_preventer/data/database/field_config.dart';
import 'package:hunger_preventer/data/database/persistent_model.dart';
import 'package:hunger_preventer/data/database/sqlite_types.dart';

enum TransactionType {
  CREDIT_CARD,
  BANK_TRANSFER,
  DIRECT_DEBIT,
}

class Transaction implements PersistentModel {
  static const String TABLE_NAME = "usertransaction";

  int _id;
  static const String ID_NAME = "id";
  static const String ID_CONFIG = SqliteTypes.PRIMARY_KEY;

  DateTime _date;
  static const String DATE_NAME = "date";
  static const String DATE_CONFIG = SqliteTypes.INT + SqliteTypes.NOT_NULL;

  int _amount;
  static const String AMOUNT_NAME = "amount";
  static const String AMOUNT_CONFIG = SqliteTypes.INT + SqliteTypes.NOT_NULL;

  TransactionType _type;
  static const String TYPE_NAME = "transaction_type";
  static const String TYPE_CONFIG = SqliteTypes.INT;

  String _iban;
  static const String IBAN_NAME = "iban";
  static const String IBAN_CONFIG = SqliteTypes.TEXT;

  String _bic;
  static const String BIC_NAME = "bic";
  static const String BIC_CONFIG = SqliteTypes.TEXT;

  Transaction(
    this._date,
    this._amount, [
    this._id,
    this._type,
    this._iban,
    this._bic,
  ]);

  Transaction.empty();

  Transaction.fromMap(Map<String, dynamic> data) {
    this._date = DateTime.fromMillisecondsSinceEpoch(data[DATE_NAME]);
    this._amount = data[AMOUNT_NAME];
    this._id = data[ID_NAME];
    this._type = data[TYPE_NAME];
    this._iban = data[IBAN_NAME];
    this._bic = data[BIC_NAME];
  }

  @override
  List<FieldConfig> getFieldConf() {
    return [
      FieldConfig(ID_NAME, ID_CONFIG),
      FieldConfig(DATE_NAME, DATE_CONFIG),
      FieldConfig(AMOUNT_NAME, AMOUNT_CONFIG),
      FieldConfig(TYPE_NAME, TYPE_CONFIG),
      FieldConfig(IBAN_NAME, IBAN_CONFIG),
      FieldConfig(BIC_NAME, BIC_CONFIG),
    ];
  }

  @override
  String getTableName() {
    return TABLE_NAME;
  }

  Map<String, dynamic> toMap() {
    var map = {
      ID_NAME: this.id,
      DATE_NAME: this.date.millisecondsSinceEpoch,
      AMOUNT_NAME: this.amount,
      TYPE_NAME: this.type,
      IBAN_NAME: this.iban,
      BIC_NAME: this.bic,
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
