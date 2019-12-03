import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hunger_preventer/data/repositories/transaction_repository.dart';
import 'package:hunger_preventer/domain/bloc/transactions/transactions_event.dart';
import 'package:hunger_preventer/domain/bloc/transactions/transactions_state.dart';

class TransactionsBloc
    extends Bloc<TransactionsEvent, TransactionsState> {
  final TransactionRepository _transactionRepository;

  TransactionsBloc(this._transactionRepository);

  @override
  TransactionsState get initialState => TransactionsEmpty();

  @override
  Stream<TransactionsState> mapEventToState(
    TransactionsEvent event,
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
