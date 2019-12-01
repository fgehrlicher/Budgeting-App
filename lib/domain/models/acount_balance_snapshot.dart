import 'package:hunger_preventer/data/database/field_config.dart';
import 'package:hunger_preventer/data/database/persistent_model.dart';

class AccountBalanceSnapshot implements PersistentModel {
  static const String TABLE_NAME = "accountbalancesnapshot";

  int id;
  DateTime date;
  int balance;

  AccountBalanceSnapshot({this.id, this.date, this.balance});

  AccountBalanceSnapshot.fromMap(Map<String, dynamic> data){
    this.id = data['id'];
    this.balance = data['balance'];
    this.date = DateTime.fromMillisecondsSinceEpoch(data['date']);
  }

  Map<String, dynamic> toMap() {
    var map = {
      'id': this.id,
      'date': this.date.millisecondsSinceEpoch,
      'balance': this.balance
    };

    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<FieldConfig> getFieldConf() {

  }

  @override
  String getTableName() {
    return TABLE_NAME;
  }
}
