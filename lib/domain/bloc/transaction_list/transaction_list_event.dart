import 'package:equatable/equatable.dart';

abstract class TransactionListEvent extends Equatable {
  const TransactionListEvent();

  @override
  List<Object> get props => [];
}

class FetchTransactions extends TransactionListEvent {}
