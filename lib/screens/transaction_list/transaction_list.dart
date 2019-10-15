import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hunger_preventer/data/integrity/balance_integrity_checker.dart';
import 'package:hunger_preventer/data/models/shadow_balance.dart';
import 'package:hunger_preventer/data/models/transaction_list.dart';
import 'package:hunger_preventer/data/repositories/balance_snapshot_repository.dart';
import 'package:hunger_preventer/data/repositories/transaction_repository.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var transactionRepository = TransactionRepository();
    var balanceRepository = BalanceSnapshotRepository();
    var balanceIntegrityChecker = BalanceIntegrityChecker();

    var transactions = transactionRepository.get(DateTime.now());
    var balanceSnapshots = balanceRepository.get(DateTime.now());

    List<Widget> children = List();

    transactions.sortBy(TransactionListSorting.DateAscending);

    for (var i = 0; i < balanceSnapshots.length; i++) {
      var isCurrentSnapshot = (i + 1 == balanceSnapshots.length);
      var snapshot = balanceSnapshots[i];
      var balance = snapshot.balance;

      children.add(
        Divider(
          color: Colors.black,
          height: 20,
          thickness: 10,
        ),
      );
      children.add(
        Text(snapshot.toString(),
            style: TextStyle(
              backgroundColor: Colors.amber,
            )),
      );

      if (!isCurrentSnapshot) {
        var nextSnapshot = balanceSnapshots[i + 1];
        var currentTransactions =
            transactions.getTransactions(snapshot.date, nextSnapshot.date);
        var offset = balanceIntegrityChecker.calculateOffset(
            snapshot, nextSnapshot, currentTransactions);

        for (var y = 0; y < currentTransactions.length; y++) {
          var style = (currentTransactions[y].amount > 0)
              ? TextStyle(backgroundColor: Colors.green)
              : TextStyle(backgroundColor: Colors.red);
          children.add(Text(
            currentTransactions[y].toString(),
            style: style,
          ));
          balance += currentTransactions[y].amount;
          children.add(Text(
            ShadowBalance(balance, currentTransactions[y].date).toString(),
            style: TextStyle(backgroundColor: Colors.grey),
          ));
        }
        if (offset != null) {
          children.add(Text(
            "!OFFSET: ${offset.balance}",
            style: TextStyle(backgroundColor: Colors.purpleAccent),
          ));
        }
      } else {
        var currentTransactions = transactions.getTransactions(
            snapshot.date, DateTime.parse("2040-01-10 13:00:00"));

        for (var y = 0; y < currentTransactions.length; y++) {
          var style = (currentTransactions[y].amount > 0)
              ? TextStyle(backgroundColor: Colors.green)
              : TextStyle(backgroundColor: Colors.red);

          children.add(Text(
            currentTransactions[y].toString(),
            style: style,
          ));
          balance += currentTransactions[y].amount;
          children.add(Text(
            ShadowBalance(balance, currentTransactions[y].date).toString(),
            style: TextStyle(backgroundColor: Colors.grey),
          ));
        }
      }
    }

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Transaction List'),
      ),
      child: ListView(
        children: children,
      ),
    );
  }
}
