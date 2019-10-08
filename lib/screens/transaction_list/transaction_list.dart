import 'package:flutter/cupertino.dart';
import 'package:hunger_preventer/data/models/transaction_list.dart';
import 'package:hunger_preventer/data/transaction_repository.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var transactionRepository = TransactionRepository();
    var transactions = transactionRepository.get(DateTime.now());
    transactions.sortBy(TransactionListSorting.DateAscending);
    List<Widget> children = List();

    for (var i = 0; i < transactions.length; i++) {
      var amount = transactions[i].amount.toString();
      var date = transactions[i].date.year.toString();
      children.add(Text("$date: $amount"));
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
