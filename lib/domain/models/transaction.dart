import 'package:unnamed_budgeting_app/data/database/field_config.dart';
import 'package:unnamed_budgeting_app/data/database/persistent_model.dart';
import 'package:unnamed_budgeting_app/data/database/sqlite_types.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction_category.dart';

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

  String title;
  static const String TITLE_NAME = "title";
  static const String TITLE_CONFIG = SqliteTypes.TEXT;

  TransactionType type;
  static const String TYPE_NAME = "transaction_type";
  static const String TYPE_CONFIG = SqliteTypes.INT;

  TransactionCategory category;
  static const String CATEGORY_NAME = "transaction_category";
  static const String CATEGORY_CONFIG = SqliteTypes.INT;

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
    this.title,
    this.type,
    this.category,
    this.iban,
    this.bic,
  });

  Transaction.fromMap(Map<String, dynamic> data) {
    date = DateTime.fromMillisecondsSinceEpoch(data[DATE_NAME]);
    amount = data[AMOUNT_NAME];
    id = data[ID_NAME];
    title = data[TITLE_NAME];
    type = data[TYPE_NAME];
    iban = data[IBAN_NAME];
    bic = data[BIC_NAME];

    int categoryId = data[CATEGORY_NAME];
    if (categoryId != null) {
      category = TransactionCategory.fromId(categoryId);
    }
  }

  @override
  List<FieldConfig> getFieldConf() {
    return [
      FieldConfig(ID_NAME, ID_CONFIG),
      FieldConfig(DATE_NAME, DATE_CONFIG),
      FieldConfig(AMOUNT_NAME, AMOUNT_CONFIG),
      FieldConfig(TITLE_NAME, TITLE_CONFIG),
      FieldConfig(TYPE_NAME, TYPE_CONFIG),
      FieldConfig(CATEGORY_NAME, CATEGORY_CONFIG),
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
      TITLE_NAME: title,
      TYPE_NAME: type,
      CATEGORY_NAME: category?.id,
      IBAN_NAME: iban,
      BIC_NAME: bic,
    };

    map.removeWhere((key, value) => value == null);
    return map;
  }

  String getFormattedBalance() {
    var minimalLength = 3;
    var postDecimalPointChars = 2;

    var rawBalance = amount != null ? amount.toString() : "";
    rawBalance = rawBalance.padLeft(minimalLength, "0");
    var balanceLength = rawBalance.length;

    var preDecimalPoint = rawBalance.substring(0, balanceLength - postDecimalPointChars);
    var postDecimalPoint = rawBalance.substring(balanceLength - postDecimalPointChars);

    return "$preDecimalPoint.$postDecimalPoint \€";
  }
}
