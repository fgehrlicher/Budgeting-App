import 'package:hunger_preventer/domain/models/transaction.dart';
import 'package:quiver/collection.dart';

enum TransactionListSorting {
  DateAscending,
  DateDescending,
}

class TransactionList extends DelegatingList<Transaction> {
  final List<Transaction> _transactions = [];

  List<Transaction> get delegate => _transactions;

  TransactionList();

  TransactionList.fromQueryResult(List<Map<String, dynamic>> data) {
    data.forEach(
          (transactionValueMap) => this.add(
        Transaction.fromMap(transactionValueMap),
      ),
    );
  }

  void sortBy(TransactionListSorting sorting) {
    int Function(Transaction, Transaction) comparisonMethod;

    if (sorting == TransactionListSorting.DateAscending) {
      comparisonMethod = this._compareDateAscending;
    } else if (sorting == TransactionListSorting.DateDescending) {
      comparisonMethod = this._compareDateDescending;
    } else {
      throw Exception("sorting ${sorting.toString()} not implemented yet.");
    }

    this.delegate.sort(comparisonMethod);
  }

  TransactionList getTransactions(DateTime from, DateTime until) {
    this._validateDate(from, until);
    var subList = TransactionList();
    subList.addAll(this._transactions.where((Transaction transaction) {
      return transaction.date.isAtSameMomentAs(until) ||
          (transaction.date.isAfter(from) && transaction.date.isBefore(until));
    }));
    return subList;
  }

  int _compareDateAscending(Transaction base, Transaction comparison) =>
      base.date.compareTo(comparison.date);

  int _compareDateDescending(Transaction base, Transaction comparison) =>
      comparison.date.compareTo(base.date);

  void _validateDate(DateTime from, DateTime until) {
    final dateComparison = until.compareTo(from);
    if (dateComparison == -1) {
      throw Exception("'from' date can´t be bigger than the 'until' date");
    } else if (dateComparison == 0) {
      throw Exception("'from' date and 'until' date cant be identical");
    }
  }
}
