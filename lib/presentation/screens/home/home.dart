import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/home/home_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/home/home_event.dart';
import 'package:unnamed_budgeting_app/domain/bloc/home/home_state.dart';
import 'package:unnamed_budgeting_app/presentation/screens/home/balance_container.dart';
import 'package:unnamed_budgeting_app/presentation/screens/home/loading_screen.dart';

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

  RefreshCallback _getRefreshCallback() {
    return () {
      _homeBloc.add(FetchCurrentBalance());
      return _refreshCompleter.future;
    };
  }

  void _completeRefresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    _refreshCompleter?.complete();
    _refreshCompleter = Completer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is BalanceCalculated) {
          _completeRefresh();
        }
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is EmptyBalance) {
                return Container();
              }

              if (state is CalculatingBalance) {
                return ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                      minWidth: constraints.maxWidth,
                    ),
                    child: LoadingScreen());
              }

              if (state is BalanceCalculated) {
                return RefreshIndicator(
                  onRefresh: _getRefreshCallback(),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                        minWidth: constraints.maxWidth,
                      ),
                      child: BalanceContainer(
                        state.accountBalance.getFormattedBalance(),
                      ),
                    ),
                  ),
                );
              }

              return Container();
            },
          );
        },
      ),
    );
  }
}
