import 'package:unnamed_budgeting_app/domain/model/acount_balance.dart';

abstract class HomeState {}

class BalanceEmpty extends HomeState {}

class BalanceCalculating extends HomeState {}

class BalanceCalculated extends HomeState {
  final AccountBalance accountBalance;

  BalanceCalculated(this.accountBalance);
}
