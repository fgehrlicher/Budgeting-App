class AccountBalance {
  final double _balance;

  AccountBalance(this._balance);

  @override
  String toString() {
    return this._balance.toString() + " €";
  }

  double get balance => _balance;
}
