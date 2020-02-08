import 'package:flutter_test/flutter_test.dart';
import 'package:unnamed_budgeting_app/domain/model/transaction.dart';
import 'package:unnamed_budgeting_app/domain/model/transaction_list.dart';

void main() {
  group("Transaction List", () {
    TransactionList subject;
    final oldestTransaction = Transaction(
      date: DateTime.parse("2010-01-01 00:13:37"),
      amount: 0,
    );
    final secondOldestTransaction = Transaction(
      date: DateTime.parse("2015-01-01 00:13:37"),
      amount: 0,
    );
    final secondNewestTransaction = Transaction(
      date: DateTime.parse("2020-01-01 00:13:37"),
      amount: 0,
    );
    final newestTransaction = Transaction(
      date: DateTime.parse("2025-01-01 00:13:37"),
      amount: 0,
    );

    final unsortedList = [
      newestTransaction,
      oldestTransaction,
      secondNewestTransaction,
      secondOldestTransaction,
    ];

    setUp(() {
      subject = TransactionList();
      subject.addAll(unsortedList);
    });

    test('Sort by "DateAscending" sorts by ascending date', () {
      List<Transaction> expectedSortedList = [
        oldestTransaction,
        secondOldestTransaction,
        secondNewestTransaction,
        newestTransaction,
      ];

      subject.sortBy(TransactionListSorting.DateAscending);

      List<Transaction> actualSortedList =
          subject.getRange(0, expectedSortedList.length).toList();
      expect(
        actualSortedList,
        expectedSortedList,
      );
    });

    test('Sort by "DateDescending" sorts by descending date', () {
      List<Transaction> expectedSortedList = [
        newestTransaction,
        secondNewestTransaction,
        secondOldestTransaction,
        oldestTransaction,
      ];

      subject.sortBy(TransactionListSorting.DateDescending);

      List<Transaction> actualSortedList =
          subject.getRange(0, expectedSortedList.length).toList();
      expect(
        actualSortedList,
        expectedSortedList,
      );
    });

    test("Get Transactions returns the right time_frame", () {
      var expectedFilteredList = TransactionList();
      expectedFilteredList.addAll([
        secondNewestTransaction,
        newestTransaction,
      ]);
      expectedFilteredList.sortBy(TransactionListSorting.DateAscending);

      TransactionList actualFilteredList = subject.getTransactions(
        secondOldestTransaction.date,
        newestTransaction.date,
      );

      actualFilteredList.sortBy(TransactionListSorting.DateAscending);

      expect(
        actualFilteredList,
        expectedFilteredList,
      );
    });

    test("Get Transactions throws exception dates are identical", () {
      expect(() {
        subject.getTransactions(
          newestTransaction.date,
          newestTransaction.date,
        );
      }, throwsException);
    });

    test("'Get Transactions if until happens after from", () {
      expect(() {
        subject.getTransactions(
          newestTransaction.date,
          oldestTransaction.date,
        );
      }, throwsException);
    });
  });
}
