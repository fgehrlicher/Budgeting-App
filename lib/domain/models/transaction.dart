import 'package:unnamed_budgeting_app/data/database/field_config.dart';
import 'package:unnamed_budgeting_app/data/database/persistent_model.dart';
import 'package:unnamed_budgeting_app/data/database/sqlite_types.dart';

enum TransactionType {
  CREDIT_CARD,
  BANK_TRANSFER,
  DIRECT_DEBIT,
}

class Transaction implements PersistentModel {
  static const String TABLE_NAME = "usertransaction";

  int id;
  static const String ID_NAME = "id";
  static const String ID_CONFIG = SqliteTypes.PRIMARY_KEY;

  DateTime date;
  static const String DATE_NAME = "date";
  static const String DATE_CONFIG = SqliteTypes.INT + SqliteTypes.NOT_NULL;

  int amount;
  static const String AMOUNT_NAME = "amount";
  static const String AMOUNT_CONFIG = SqliteTypes.INT + SqliteTypes.NOT_NULL;

  TransactionType type;
  static const String TYPE_NAME = "transaction_type";
  static const String TYPE_CONFIG = SqliteTypes.INT;

  String iban;
  static const String IBAN_NAME = "iban";
  static const String IBAN_CONFIG = SqliteTypes.TEXT;

  String bic;
  static const String BIC_NAME = "bic";
  static const String BIC_CONFIG = SqliteTypes.TEXT;

  Transaction({
    this.date,
    this.amount,
    this.id,
    this.type,
    this.iban,
    this.bic,
  });

  Transaction.fromMap(Map<String, dynamic> data) {
    date = DateTime.fromMillisecondsSinceEpoch(data[DATE_NAME]);
    amount = data[AMOUNT_NAME];
    id = data[ID_NAME];
    type = data[TYPE_NAME];
    iban = data[IBAN_NAME];
    bic = data[BIC_NAME];
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
      ID_NAME: id,
      DATE_NAME: date.millisecondsSinceEpoch,
      AMOUNT_NAME: amount,
      TYPE_NAME: type,
      IBAN_NAME: iban,
      BIC_NAME: bic,
    };

    map.removeWhere((key, value) => value == null);
    return map;
  }
}
