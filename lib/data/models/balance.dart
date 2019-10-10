class Balance {
  final double _balance;

  Balance(this._balance);

  @override
  String toString() {
    return this._balance.toString() + " €";
  }
}
