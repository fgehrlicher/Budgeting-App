import 'package:hunger_preventer/data/models/balance_snapshot.dart';

class BalanceSnapshotRepository {
  List<AccountBalanceSnapshot> get(DateTime from, [DateTime until]) {
    until ??= DateTime.now();
    return null;
  }
}
