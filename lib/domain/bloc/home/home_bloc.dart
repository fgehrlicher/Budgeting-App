import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/home/home_event.dart';
import 'package:unnamed_budgeting_app/domain/bloc/home/home_state.dart';
import 'package:unnamed_budgeting_app/domain/model/acount_balance.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc();

  @override
  HomeState get initialState => BalanceEmpty();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is FetchBalance) {
      yield* _mapFetchBalanceToState();
    }
  }

  Stream<HomeState> _mapFetchBalanceToState() async* {
    yield BalanceCalculating();
    var accountBalance = AccountBalance(balance: Random().nextInt(50000));
    if (accountBalance != null) {
      yield BalanceCalculated(accountBalance);
    } else {
      yield BalanceEmpty();
    }
  }
}
