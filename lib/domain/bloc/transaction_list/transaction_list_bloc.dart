import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hunger_preventer/data/repositories/transaction_repository.dart';
import 'package:hunger_preventer/domain/bloc/transaction_list/transaction_list_event.dart';
import 'package:hunger_preventer/domain/bloc/transaction_list/transaction_list_state.dart';

class TransactionListBloc
    extends Bloc<TransactionListEvent, TransactionListState> {
  final TransactionRepository _transactionRepository;

  TransactionListBloc(this._transactionRepository);

  @override
  TransactionListState get initialState => TransactionsEmpty();

  @override
  Stream<TransactionListState> mapEventToState(
    TransactionListEvent event,
  ) async* {
    if (event is FetchTransactions) {
      yield TransactionsLoading();
      var transactions = await this._transactionRepository.getAll();
      if (transactions.length > 0) {
        yield TransactionsLoaded(transactions);
      } else {
        yield TransactionsEmpty();
      }
    }
  }
}
