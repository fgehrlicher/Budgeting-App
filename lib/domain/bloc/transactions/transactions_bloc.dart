import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:unnamed_budgeting_app/data/repositories/transaction_category_repository.dart';
import 'package:unnamed_budgeting_app/data/repositories/transaction_repository.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_event.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_state.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction_list.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final TransactionRepository _transactionRepository;
  final TransactionCategoryRepository _transactionCategoryRepository;

  TransactionsBloc(
    this._transactionRepository,
    this._transactionCategoryRepository,
  );

  @override
  TransactionsState get initialState => TransactionsInitialLoading();

  @override
  Stream<TransactionsState> mapEventToState(
    TransactionsEvent event,
  ) async* {
    if (event is LoadTransactions) {
      yield* _mapLoadTransactionsToState(event);
    }
    if (event is DeleteTransaction) {
      yield* _mapDeleteTransactionToState(event);
    }
    if (event is RestoreTransaction) {
      yield* _mapRestoreTransactionToState(event);
    }
    if (event is AddTransaction) {
      yield* _mapAddTransactionToState(event);
    }
    if (event is FetchTransactions) {
      yield* _mapFetchTransactionsToState(event);
    }
  }

  Stream<TransactionsState> _mapLoadTransactionsToState(
    LoadTransactions event,
  ) async* {
    var transactions = TransactionList()
      ..addAll(await _transactionRepository.getAll());
    transactions.sortBy(TransactionListSorting.DateDescending);
    transactions.map((transaction) async {
      var transactionCategory =
          await _transactionCategoryRepository.get(id: transaction.id);

      transaction.category = transactionCategory;
    });

    if (transactions.length > 0) {
      yield TransactionsLoaded(transactionList: transactions);
    } else {
      yield TransactionsEmpty();
    }
  }

  Stream<TransactionsState> _mapDeleteTransactionToState(
    DeleteTransaction event,
  ) async* {
    //_transactionRepository.delete(transaction);
    yield TransactionDeleted(transaction: event.transaction);
  }

  Stream<TransactionsState> _mapAddTransactionToState(
    AddTransaction event,
  ) async* {
    //_transactionRepository.add(transaction);
    yield TransactionAdded(transaction: event.transaction);
  }

  Stream<TransactionsState> _mapRestoreTransactionToState(
    RestoreTransaction event,
  ) async* {
    //_transactionRepository.add(transaction);
    yield TransactionRestored(transaction: event.transaction);
  }

  Stream<TransactionsState> _mapFetchTransactionsToState(
    FetchTransactions event,
  ) async* {
    var transactions = TransactionList()
      ..addAll(
        await _transactionRepository.getAll(
          limit: event.fetchCount,
          offset: event.lastTransaction.id,
        ),
      );
    yield TransactionFetched(transactionList: transactions);
  }
}
