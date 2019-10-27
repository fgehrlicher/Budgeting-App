import 'package:flutter_test/flutter_test.dart';
import 'package:hunger_preventer/domain/integrity/balance_integrity_checker.dart';
import 'package:hunger_preventer/domain/models/balance_snapshot.dart';
import 'package:hunger_preventer/domain/models/transaction.dart';
import 'package:hunger_preventer/domain/models/transaction_list.dart';
import 'package:mockito/mockito.dart';

import '../models/transaction_list_mock.dart';

void main() {
  group("Balanace Integrity Checker", () {
    BalanceIntegrityChecker subject;
    TransactionListMock dummyTransactions;

    final dummyFrom = AccountBalanceSnapshot(
      1000,
      DateTime.parse("2020-01-01 10:00:00"),
    );

    final dummyUntil = AccountBalanceSnapshot(
      2000,
      DateTime.parse("2020-02-01 10:00:00"),
    );

    setUp(() {
      subject = BalanceIntegrityChecker();
      dummyTransactions = TransactionListMock();
    });

    test("'check' returns the correct postive deviating balance", () {
      final transactions = [
        Transaction(
          dummyFrom.date.add(
            new Duration(days: 1),
          ),
          1000,
        ),
        Transaction(
          dummyFrom.date.add(
            new Duration(days: 2),
          ),
          1000,
        ),
      ];
      final exceptedOffset = 1000;

      when(dummyTransactions.length).thenReturn(transactions.length);
      when(dummyTransactions[0]).thenReturn(transactions[0]);
      when(dummyTransactions[1]).thenReturn(transactions[1]);

      var result =
          subject.calculateOffset(dummyFrom, dummyUntil, dummyTransactions);

      expect(result.balance, exceptedOffset);
    });

    test("'check' returns the correct negative deviating balance", () {
      final transactions = [
        Transaction(
          dummyFrom.date.add(
            new Duration(days: 1),
          ),
          400,
        ),
        Transaction(
          dummyFrom.date.add(
            new Duration(days: 1),
          ),
          600,
        ),
        Transaction(
          dummyFrom.date.add(
            new Duration(days: 2),
          ),
          -4500,
        ),
      ];
      final exceptedOffset = -4500;

      when(dummyTransactions.length).thenReturn(transactions.length);
      when(dummyTransactions[0]).thenReturn(transactions[0]);
      when(dummyTransactions[1]).thenReturn(transactions[1]);
      when(dummyTransactions[2]).thenReturn(transactions[2]);

      var result =
      subject.calculateOffset(dummyFrom, dummyUntil, dummyTransactions);

      expect(result.balance, exceptedOffset);
    });

    test("'check' throws exception dates are identical", () {
      final date = DateTime.parse("2010-01-01 10:00:00");
      final balanceSnapshot = AccountBalanceSnapshot(0, date);

      expect(() {
        subject.calculateOffset(
          balanceSnapshot,
          balanceSnapshot,
          TransactionList(),
        );
      }, throwsException);
    });

    test("'check' throws exception if until happens after from", () {
      final fromDate = DateTime.parse("2020-01-01 10:00:00");
      final untilDate = DateTime.parse("2010-01-01 10:00:00");
      final from = AccountBalanceSnapshot(0, fromDate);
      final until = AccountBalanceSnapshot(0, untilDate);

      expect(() {
        subject.calculateOffset(from, until, TransactionList());
      }, throwsException);
    });
  });
}
