import 'package:equatable/equatable.dart';
import 'package:hunger_preventer/domain/models/transaction_list.dart';

abstract class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object> get props => [];
}

class TransactionsEmpty extends TransactionsState{}

class TransactionsLoading extends TransactionsState{}

class TransactionsLoaded extends TransactionsState{
  final TransactionList transactions;

  const TransactionsLoaded(this.transactions);

  @override
  List<Object> get props => transactions;
}
