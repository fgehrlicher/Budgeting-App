import 'package:hunger_preventer/data/database/field_config.dart';
import 'package:hunger_preventer/data/database/persistent_model.dart';
import 'package:hunger_preventer/data/database/sqlite_types.dart';

class AccountBalance implements PersistentModel {
  static const String TABLE_NAME = "accountbalance";

  int id;
  static const String ID_NAME = "id";
  static const String ID_CONFIG = SqliteTypes.PRIMARY_KEY;

  DateTime date;
  static const String DATE_NAME = "date";
  static const String DATE_CONFIG = SqliteTypes.INT + SqliteTypes.NOT_NULL;

  int balance;
  static const String BALANCE_NAME = "balance";
  static const String BALANCE_CONFIG = SqliteTypes.INT + SqliteTypes.NOT_NULL;

  AccountBalance({this.id, this.date, this.balance});

  AccountBalance.fromMap(Map<String, dynamic> data) {
    this.id = data[ID_NAME];
    this.balance = data[BALANCE_NAME];
    this.date = DateTime.fromMillisecondsSinceEpoch(data[DATE_NAME]);
  }

  Map<String, dynamic> toMap() {
    var map = {
      ID_NAME: this.id,
      DATE_NAME: this.date.millisecondsSinceEpoch,
      BALANCE_NAME: this.balance
    };

    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<FieldConfig> getFieldConf() {
    return [
      FieldConfig(ID_NAME, ID_CONFIG),
      FieldConfig(DATE_NAME, DAT E_CONFIG),
      FieldConfig(BALANCE_NAME, BALANCE_CONFIG),
    ];
  }

  @override
  String getTableName() {
    return TABLE_NAME;
  }
}
