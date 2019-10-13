import 'package:hunger_preventer/data/models/balance_snapshot.dart';

class BalanceSnapshotRepository {
  List<BalanceSnapshot> get(DateTime from, [DateTime until]) {
    until ??= DateTime.now();
    var balanceSnapshots = [
      BalanceSnapshot(0, DateTime.parse("2020-01-01 0:00:00")),
      BalanceSnapshot(2800, DateTime.parse("2020-01-02 13:00:00")),
      BalanceSnapshot(1000, DateTime.parse("2020-01-10 13:00:00"))
    ];
    return balanceSnapshots;
  }
}
