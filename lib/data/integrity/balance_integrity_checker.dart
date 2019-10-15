import 'package:hunger_preventer/data/models/account_balance.dart';
import 'package:hunger_preventer/data/models/balance_snapshot.dart';
import 'package:hunger_preventer/data/models/transaction.dart';
import 'package:hunger_preventer/data/models/transaction_list.dart';

class BalanceIntegrityChecker {
  AccountBalance calculateOffset(
    AccountBalanceSnapshot from,
    AccountBalanceSnapshot until,
    TransactionList transactions,
  ) {
    this._validateDate(from.date, until.date);
    double calculationBalance = from.balance;
    transactions.sortBy(TransactionListSorting.DateAscending);

    for (var i = 0; i < transactions.length; i++) {
      Transaction transaction = transactions[i];
      this._validateTransaction(from.date, until.date, transaction);
      calculationBalance += transaction.amount;
    }

    var offset = calculationBalance - until.balance;

    return (calculationBalance != until.balance)
        ? AccountBalance(offset)
        : null;
  }

  void _validateTransaction(
    DateTime from,
    DateTime until,
    Transaction transaction,
  ) {
    if (transaction.date.isBefore(from) || transaction.date.isAfter(until)) {
      throw Exception("transaction is not in range");
    }
  }

  void _validateDate(DateTime from, DateTime until) {
    final dateComparison = until.compareTo(from);
    if (dateComparison == -1) {
      throw Exception("'from' date can´t be bigger than the 'until' date");
    } else if (dateComparison == 0) {
      throw Exception("'from' date and 'until' date cant be identical");
    }
  }
}
