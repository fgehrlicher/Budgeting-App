class AccountBalance {
  final int _balance;

  AccountBalance(this._balance);

  @override
  String toString() {
    return this._balance.toString() + " €";
  }

  int get balance => _balance;
}
