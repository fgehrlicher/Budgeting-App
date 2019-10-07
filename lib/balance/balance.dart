import 'package:scoped_model/scoped_model.dart';

class Balance extends Model{
  final double _balance;

  Balance(this._balance);

  @override
  String toString() {
    return this._balance.toString() + " €";
  }
}
