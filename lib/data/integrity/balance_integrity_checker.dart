import 'package:hunger_preventer/data/models/balance.dart';
import 'package:hunger_preventer/data/models/balance_snapshot.dart';
import 'package:hunger_preventer/data/models/transaction.dart';
import 'package:hunger_preventer/data/models/transaction_list.dart';

class BalanceIntegrityChecker {
  Balance check(
    BalanceSnapshot from,
    BalanceSnapshot until,
    TransactionList transactions,
  ) {
    final dateComparison = until.date.compareTo(from.date);
    if (dateComparison == -1) {
      throw Exception("'from' date can´t be bigger than the 'until' date");
    } else if (dateComparison == 0) {
      throw Exception("'from' date and 'until' date cant be identical");
    }

    double balance = from.balance;
    transactions.sortBy(TransactionListSorting.DateAscending);
    for (var i = 0; i < transactions.length; i++) {
      Transaction transaction = transactions[i];
      if (transaction.date.isBefore(from.date) ||
          transaction.date.isAfter(until.date)) {
        throw Exception("transaction is not in range");
      }
      balance += transaction.amount;
    }

    return (balance != until.balance) ? Balance(until.balance - balance) : null;
  }
}
