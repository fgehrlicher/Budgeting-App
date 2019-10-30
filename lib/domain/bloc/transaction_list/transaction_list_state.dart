import 'package:equatable/equatable.dart';
import 'package:hunger_preventer/domain/models/transaction.dart';

abstract class TransactionListState extends Equatable {
  const TransactionListState();

  @override
  List<Object> get props => [];
}

class TransactionsEmpty extends TransactionListState{}

class TransactionsLoading extends TransactionListState{}

class TransactionsLoaded extends TransactionListState{
  final List<Transaction> transactions;

  const TransactionsLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}

