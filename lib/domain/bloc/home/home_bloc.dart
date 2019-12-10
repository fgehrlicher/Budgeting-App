import 'dart:async';
import 'dart:io';
import 'dart:math';
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
      var accountBalance = AccountBalance(balance: Random().nextInt(50000));
      await Future.delayed(Duration(milliseconds: 500));

      if (accountBalance != null) {
        yield BalanceCalculated(accountBalance);
      } else {
        yield EmptyBalance();
      }
    }
  }
}
