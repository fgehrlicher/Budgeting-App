import 'package:equatable/equatable.dart';

abstract class TransactionListState extends Equatable {
  const TransactionListState();
}

class InitialTransactionListState extends TransactionListState {
  @override
  List<Object> get props => [];
}
