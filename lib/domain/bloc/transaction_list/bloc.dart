import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hunger_preventer/domain/bloc/transaction_list/event.dart';
import 'package:hunger_preventer/domain/bloc/transaction_list/state.dart';


class TransactionListBloc extends Bloc<TransactionListEvent, TransactionListState> {
  @override
  TransactionListState get initialState => InitialTransactionListState();

  @override
  Stream<TransactionListState> mapEventToState(
    TransactionListEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
