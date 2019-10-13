import 'package:hunger_preventer/data/models/transaction.dart';
import 'package:quiver/collection.dart';

enum TransactionListSorting {
  DateAscending,
  DateDescending,
}

class TransactionList extends DelegatingList<Transaction> {
  final List<Transaction> _transactions = [];

  List<Transaction> get delegate => _transactions;

  void sortBy(TransactionListSorting sorting) {
    int Function(Transaction, Transaction) comparisonMethod;

    if (sorting == TransactionListSorting.DateAscending) {
      comparisonMethod = this._compareDateAscending;
    } else if (sorting == TransactionListSorting.DateDescending) {
      comparisonMethod = this._compareDateDescending;
    } else {
      throw new Exception("sorting ${sorting.toString()} not implemented yet.");
    }

    this.delegate.sort(comparisonMethod);
  }

  TransactionList getTransactions(DateTime from, DateTime until) {
    var subList = new TransactionList();
    subList.addAll(this._transactions.where((Transaction transaction) {
      return transaction.date.isAtSameMomentAs(from) ||
          (transaction.date.isAfter(from) && transaction.date.isBefore(until));
    }));
    return subList;
  }

  int _compareDateAscending(Transaction base, Transaction comparison) =>
      base.date.compareTo(comparison.date);

  int _compareDateDescending(Transaction base, Transaction comparison) =>
      comparison.date.compareTo(base.date);
}
