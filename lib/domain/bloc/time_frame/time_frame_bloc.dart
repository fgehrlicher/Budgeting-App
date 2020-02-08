import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:unnamed_budgeting_app/data/repository/transaction_category_repository.dart';
import 'package:unnamed_budgeting_app/data/repository/transaction_repository.dart';
import 'package:unnamed_budgeting_app/domain/bloc/time_frame/time_frame_event.dart';
import 'package:unnamed_budgeting_app/domain/bloc/time_frame/time_frame_state.dart';
import 'package:unnamed_budgeting_app/domain/model/time_frame.dart';
import 'package:unnamed_budgeting_app/domain/model/transaction_list.dart';

class TimeFrameBloc extends Bloc<TimeFrameEvent, TimeFrameState> {
  final TransactionRepository _transactionRepository;
  final TransactionCategoryRepository _transactionCategoryRepository;

  TimeFrameBloc(
    this._transactionRepository,
    this._transactionCategoryRepository,
  );

  @override
  TimeFrameState get initialState => TimeFrameInitialLoading();

  @override
  Stream<TimeFrameState> mapEventToState(
    TimeFrameEvent event,
  ) async* {
    if (event is LoadTimeFrame) {
      yield* _mapLoadTimeFrameToState(event);
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
    if (event is FetchTimeFrame) {
      yield* _mapFetchTimeFrameToState(event);
    }
  }

  Stream<TimeFrameState> _mapLoadTimeFrameToState(
    LoadTimeFrame event,
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
      yield TimeFramesLoaded(
        timeFrames: [
          TimeFrame(transactions: transactions),
        ],
      );
    } else {
      yield NoTimeFrame();
    }
  }

  Stream<TimeFrameState> _mapDeleteTransactionToState(
    DeleteTransaction event,
  ) async* {
    //_transactionRepository.delete(transaction);
    yield TransactionDeleted(transaction: event.transaction);
  }

  Stream<TimeFrameState> _mapAddTransactionToState(
    AddTransaction event,
  ) async* {
    //_transactionRepository.add(transaction);
    yield TransactionAdded(transaction: event.transaction);
  }

  Stream<TimeFrameState> _mapRestoreTransactionToState(
    RestoreTransaction event,
  ) async* {
    //_transactionRepository.add(transaction);
    yield TransactionRestored(transaction: event.transaction);
  }

  Stream<TimeFrameState> _mapFetchTimeFrameToState(
    FetchTimeFrame event,
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

    yield TimeFramesFetched(
      timeFrames: [
        TimeFrame(transactions: transactions),
      ],
    );
  }
}
