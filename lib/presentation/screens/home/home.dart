import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hunger_preventer/domain/bloc/home/home_bloc.dart';
import 'package:hunger_preventer/domain/bloc/home/home_event.dart';
import 'package:hunger_preventer/domain/bloc/home/home_state.dart';
import 'package:hunger_preventer/presentation/screens/home/balance_container.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeBloc _homeBloc;
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is EmptyBalance) {
          return Container();
        }
        if (state is CalculatingBalance) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is BalanceCalculated) {
          return BalanceContainer(
            headline: "Available Amount:",
            body: state.accountBalance.getBalanceString(),
            refreshCallback: _refreshCallback(),
          );
        }

        return Container();
      },
    );
  }

  RefreshCallback _refreshCallback() {
    return () {
      _homeBloc.add(FetchCurrentBalance());
      return _refreshCompleter.future;
    };
  }

}
