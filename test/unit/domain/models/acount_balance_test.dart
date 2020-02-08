import 'package:flutter_test/flutter_test.dart';
import 'package:unnamed_budgeting_app/domain/model/acount_balance.dart';

void main() {
  group("Account Balance", () {

    test('getFormattedBalance returns the correct Balance String', () {
      var cents = 10000;
      var euroString = "100.00 €";
      var subject = AccountBalance(balance: cents);

      expect(
        subject.formattedBalance,
        euroString,
      );
    });

    test('the returned balance gets rounded to a minimum length of 3 ', () {
      var cents = 1;
      var euroString = "0.01 €";

      var subject = AccountBalance(balance: cents);

      expect(
        subject.formattedBalance,
        euroString,
      );
    });

    test('empty balance returns the correct string', () {
      var euroString = "0.00 €";
      var subject = AccountBalance();

      expect(
        subject.formattedBalance,
        euroString,
      );
    });

  });
}
