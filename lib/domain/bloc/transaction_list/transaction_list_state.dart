import 'package:equatable/equatable.dart';
import 'package:hunger_preventer/domain/models/transaction_list.dart';

abstract class TransactionListState extends Equatable {
  const TransactionListState();

  @override
  List<Object> get props => [];
}

class TransactionsEmpty extends TransactionListState{}

class TransactionsLoading extends TransactionListState{}

class TransactionsLoaded extends TransactionListState{
  final TransactionList transactions;

  const TransactionsLoaded(this.transactions);

  @override
  List<Object> get props => transactions;
}
