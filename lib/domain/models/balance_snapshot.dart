import 'package:hunger_preventer/domain/models/account_balance.dart';

class AccountBalanceSnapshot extends AccountBalance {
  static const String TABLE_NAME = "accountbalancesnapshot";

  DateTime _date;
  int _id;

  AccountBalanceSnapshot(int balance, this._date, [this._id]) : super(balance);

  AccountBalanceSnapshot.fromMap(Map<String, dynamic> data)
      : super(data['balance']) {
    this._id = data['id'];
    this._date = DateTime.fromMillisecondsSinceEpoch(data['date']);
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

  DateTime get date => _date;

  int get id => _id;
}
