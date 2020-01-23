import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/home/home_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/home/home_event.dart';
import 'package:unnamed_budgeting_app/domain/bloc/home/home_state.dart';
import 'package:unnamed_budgeting_app/domain/bloc/navigation/navigation_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/navigation/navigation_state.dart';
import 'package:unnamed_budgeting_app/presentation/screens/home/balance_container.dart';
import 'package:unnamed_budgeting_app/presentation/screens/home/loading_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeBloc _homeBloc;
  NavigationBloc _navigationBloc;
  Completer<void> _refreshCompleter;
  bool _isUpdating = false;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _navigationBloc = BlocProvider.of<NavigationBloc>(context);
    _refreshCompleter = Completer<void>();

    _navigationBloc.listen(_handleNavigationStateUpdate);
  }

  void _handleNavigationStateUpdate(NavigationState state) {
    if (state is SamePage) {
      _handleSamePageState(state);
    }
  }

  void _handleSamePageState(SamePage state) {
    if (_isUpdating) {
      return;
    }

    _isUpdating = true;
    _refreshIndicatorKey.currentState.show();
  }

  Future<void> _refresh() {
    _homeBloc.add(FetchBalance());
    return _refreshCompleter.future;
  }

  void _completeRefresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    _refreshCompleter?.complete();
    _isUpdating = false;
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
              if (state is BalanceEmpty) {
                return Container();
              }

              if (state is BalanceCalculating) {
                return ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                      minWidth: constraints.maxWidth,
                    ),
                    child: LoadingScreen());
              }

              if (state is BalanceCalculated) {
                return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: _refresh,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                        minWidth: constraints.maxWidth,
                      ),
                      child: BalanceContainer(
                        state.accountBalance.formattedBalance,
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
