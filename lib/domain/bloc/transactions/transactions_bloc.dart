import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:unnamed_budgeting_app/data/repository/transaction_category_repository.dart';
import 'package:unnamed_budgeting_app/data/repository/transaction_repository.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_event.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_state.dart';
import 'package:unnamed_budgeting_app/domain/model/transaction_list.dart';

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
    var rawTransactions =
        await _transactionRepository.getAll(limit: event.loadCount);
    var transactionCategories = await _transactionCategoryRepository.getAll();

    var mappedRawTransactions = rawTransactions.map((transaction) {
      transaction.category = transactionCategories.firstWhere(
          (transactionCategory) =>
              transactionCategory.id == transaction.categoryId);
      return transaction;
    });

    var transactions = TransactionList()..addAll(mappedRawTransactions);
    transactions.sortBy(TransactionListSorting.DateDescending);

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
    var rawTransactions =
    await _transactionRepository.getAll(limit: event.fetchCount);
    var transactionCategories = await _transactionCategoryRepository.getAll();

    var mappedRawTransactions = rawTransactions.map((transaction) {
      transaction.category = transactionCategories.firstWhere(
              (transactionCategory) =>
          transactionCategory.id == transaction.categoryId);
      return transaction;
    });

    var transactions = TransactionList()..addAll(mappedRawTransactions);
    transactions.sortBy(TransactionListSorting.DateDescending);

    yield TransactionFetched(transactionList: transactions);
  }
}
