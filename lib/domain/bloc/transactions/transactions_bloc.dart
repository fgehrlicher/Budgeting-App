import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:unnamed_budgeting_app/data/repositories/transaction_repository.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_event.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_state.dart';

class TransactionsBloc
    extends Bloc<TransactionsEvent, TransactionsState> {
  final TransactionRepository _transactionRepository;

  TransactionsBloc(this._transactionRepository);

  @override
  TransactionsState get initialState => TransactionsInitialLoading();

  @override
  Stream<TransactionsState> mapEventToState(
    TransactionsEvent event,
  ) async* {
    if (event is FetchTransactions) {
      var transactions = await _transactionRepository.getAll();
      await Future.delayed(Duration(milliseconds: 500));

      if (transactions.length > 0) {
        yield TransactionsLoaded(transactions);
      } else {
        yield TransactionsEmpty();
      }
    }
  }
}
