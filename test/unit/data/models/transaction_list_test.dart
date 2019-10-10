import 'package:flutter_test/flutter_test.dart';
import 'package:hunger_preventer/data/models/transaction.dart';
import 'package:hunger_preventer/data/models/transaction_list.dart';

void main() {
  group("Transaction List", () {
    TransactionList subject;
    final oldestTransaction = Transaction(
      DateTime.parse("2010-01-01 00:13:37"),
      0,
    );
    final secondOldestTransaction = Transaction(
      DateTime.parse("2015-01-01 00:13:37"),
      0,
    );
    final secondNewestTransaction = Transaction(
      DateTime.parse("2020-01-01 00:13:37"),
      0,
    );
    final newestTransaction = Transaction(
      DateTime.parse("2025-01-01 00:13:37"),
      0,
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
      final List<Transaction> expectedSortedList = [
        oldestTransaction,
        secondOldestTransaction,
        secondNewestTransaction,
        newestTransaction,
      ];

      subject.sortBy(TransactionListSorting.DateAscending);

      expect(
        subject.getRange(0, expectedSortedList.length).toList(),
        expectedSortedList,
      );
    });

    test('Sort by "DateDescending" sorts by descending date', () {
      final List<Transaction> expectedSortedList = [
        newestTransaction,
        secondNewestTransaction,
        secondOldestTransaction,
        oldestTransaction,
      ];

      subject.sortBy(TransactionListSorting.DateDescending);

      expect(
        subject.getRange(0, expectedSortedList.length).toList(),
        expectedSortedList,
      );
    });
  });
}
