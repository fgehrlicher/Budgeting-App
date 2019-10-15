import 'package:hunger_preventer/data/models/balance_snapshot.dart';

class BalanceSnapshotRepository {
  List<AccountBalanceSnapshot> get(DateTime from, [DateTime until]) {
    until ??= DateTime.now();
    var balanceSnapshots = [
      AccountBalanceSnapshot(0, DateTime.parse("2020-01-01 00:00:00")),
      AccountBalanceSnapshot(2700, DateTime.parse("2020-01-02 13:00:00")),
      AccountBalanceSnapshot(10000, DateTime.parse("2020-01-10 13:00:00"))
    ];
    return balanceSnapshots;
  }
}
