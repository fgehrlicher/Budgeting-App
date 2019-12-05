import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hunger_preventer/domain/bloc/home/home_event.dart';
import 'package:hunger_preventer/domain/bloc/home/home_state.dart';
import 'package:hunger_preventer/domain/models/acount_balance.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc();

  @override
  HomeState get initialState => EmptyBalance();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is FetchCurrentBalance) {
      yield CalculatingBalance();
      var accountBalance = AccountBalance(balance: 2800);
      if (accountBalance != null) {
        yield BalanceCalculated(accountBalance);
      } else {
        yield EmptyBalance();
      }
    }
  }
}
