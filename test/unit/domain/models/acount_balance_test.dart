import 'package:flutter_test/flutter_test.dart';
import 'package:hunger_preventer/domain/models/acount_balance.dart';

void main() {
  group("Account Balance", () {

    test('getBalanceString returns the correct Balance String', () {
      var cents = 10000;
      var euroString = "100.00 €";
      var subject = AccountBalance(balance: cents);

      expect(
        subject.getBalanceString(),
        euroString,
      );
    });

    test('the returned balance gets rounded to a minimum length of 3 ', () {
      var cents = 1;
      var euroString = "0.01 €";

      var subject = AccountBalance(balance: cents);

      expect(
        subject.getBalanceString(),
        euroString,
      );
    });

    test('empty balance returns the correct string', () {
      var euroString = "0.00 €";
      var subject = AccountBalance();

      expect(
        subject.getBalanceString(),
        euroString,
      );
    });

  });
}
