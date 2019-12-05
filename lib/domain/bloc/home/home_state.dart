import 'package:equatable/equatable.dart';
import 'package:hunger_preventer/domain/models/acount_balance.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class EmptyBalance extends HomeState {}

class CalculatingBalance extends HomeState {}

class BalanceCalculated extends HomeState {
  final AccountBalance accountBalance;

  const BalanceCalculated(this.accountBalance);

  @override
  List<Object> get props => [accountBalance];
}
