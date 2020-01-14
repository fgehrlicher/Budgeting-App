import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:unnamed_budgeting_app/data/repositories/transaction_repository.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_event.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_state.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction_list.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final TransactionRepository _transactionRepository;

  TransactionsBloc(this._transactionRepository);

  @override
  TransactionsState get initialState => TransactionsInitialLoading();

  @override
  Stream<TransactionsState> mapEventToState(
    TransactionsEvent event,
  ) async* {
    if (event is FetchTransactions) {
      yield* _mapFetchTransactionsToState();
    }
    if (event is DeleteTransaction) {
      yield* _mapDeleteTransactionToState(event.transaction);
    }
    if (event is AddTransaction) {
      yield* _mapAddTransactionToState(event.transaction);
    }
  }

  Stream<TransactionsState> _mapFetchTransactionsToState() async* {
    var transactions = await _transactionRepository.getAll();
    transactions.sortBy(TransactionListSorting.DateDescending);

    if (transactions.length > 0) {
      yield TransactionsLoaded(transactions);
    } else {
      yield TransactionsEmpty();
    }
  }

  Stream<TransactionsState> _mapDeleteTransactionToState(Transaction transaction) async* {
    //_transactionRepository.delete(transaction);
    yield TransactionDeleted(transaction);
  }

  Stream<TransactionsState> _mapAddTransactionToState(Transaction transaction) async* {
    //_transactionRepository.delete(transaction);
    yield TransactionAdded(transaction);
  }
}
