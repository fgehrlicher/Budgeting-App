import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:unnamed_budgeting_app/data/repositories/transaction_category_repository.dart';
import 'package:unnamed_budgeting_app/data/repositories/transaction_repository.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_event.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_state.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction_category.dart';
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
      yield* _mapLoadTransactionsToState();
    }
    if (event is DeleteTransaction) {
      yield* _mapDeleteTransactionToState(event.transaction);
    }
    if (event is RestoreTransaction) {
      yield* _mapRestoreTransactionToState(event.transaction);
    }
    if (event is AddTransaction) {
      yield* _mapAddTransactionToState(event.transaction);
    }
    if (event is FetchTransactions) {
      yield* _mapFetchTransactionsToState(event);
    }
  }

  Stream<TransactionsState> _mapLoadTransactionsToState() async* {
    var transactions = await _transactionRepository.getAll();
    transactions.sortBy(TransactionListSorting.DateDescending);
    transactions.map((transaction) async {
      var transactionCategory = await _transactionCategoryRepository
          .get(transaction.id);

      transaction.category = transactionCategory;
    });

    if (transactions.length > 0) {
      yield TransactionsLoaded(transactions);
    } else {
      yield TransactionsEmpty();
    }
  }

  Stream<TransactionsState> _mapDeleteTransactionToState(
    Transaction transaction,
  ) async* {
    //_transactionRepository.delete(transaction);
    yield TransactionDeleted(transaction);
  }

  Stream<TransactionsState> _mapAddTransactionToState(
    Transaction transaction,
  ) async* {
    //_transactionRepository.add(transaction);
    yield TransactionAdded(transaction);
  }

  Stream<TransactionsState> _mapRestoreTransactionToState(
    Transaction transaction,
  ) async* {
    //_transactionRepository.add(transaction);
    yield TransactionRestored(transaction);
  }

  Stream<TransactionsState> _mapFetchTransactionsToState(
    FetchTransactions event,
  ) async* {
    var transactions = await _transactionRepository.getAll(
      limit: event.fetchCount,
      after: event.lastTransaction,
    );
    yield TransactionFetched(transactions);
  }
}
