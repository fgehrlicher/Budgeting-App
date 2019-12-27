import 'package:equatable/equatable.dart';
import 'package:unnamed_budgeting_app/domain/models/acount_balance.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => List();
}

class BalanceEmpty extends HomeState {}

class BalanceCalculating extends HomeState {}

class BalanceCalculated extends HomeState {
  final AccountBalance accountBalance;

  const BalanceCalculated(this.accountBalance);

  @override
  List<Object> get props => [accountBalance];
}
