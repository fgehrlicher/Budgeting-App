import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/navigation/navigation_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/navigation/navigation_state.dart';
import 'package:unnamed_budgeting_app/domain/bloc/time_frame/time_frame_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/time_frame/time_frame_event.dart';
import 'package:unnamed_budgeting_app/domain/bloc/time_frame/time_frame_state.dart';
import 'package:unnamed_budgeting_app/domain/model/acount_balance.dart';
import 'package:unnamed_budgeting_app/domain/model/time_frame.dart';
import 'package:unnamed_budgeting_app/domain/model/transaction.dart';
import 'package:unnamed_budgeting_app/presentation/screens/transactions/transaction_list/card_item.dart';
import 'package:unnamed_budgeting_app/presentation/screens/transactions/edit_transaction/edit_transaction.dart';
import 'package:unnamed_budgeting_app/presentation/screens/transactions/transaction_list/fetch_indicator.dart';
import 'package:unnamed_budgeting_app/presentation/widgets/list_model.dart';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList>
    with AutomaticKeepAliveClientMixin {
  TimeFrameBloc _transactionsBloc;
  NavigationBloc _navigationBloc;
  Completer<void> _refreshCompleter;
  ScrollController _scrollController;
  bool _transactionsLeft;
  bool _isScrollingUp;
  bool _isUpdating;

  ListModel<Transaction> _transactions;
  GlobalKey<AnimatedListState> _transactionsKey =
      GlobalKey<AnimatedListState>();
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  int _lastDeletedIndex;
  ScaffoldState _mainScaffold;
  FetchIndicator _fetchIndicator;

  _TransactionListState() {
    _refreshCompleter = Completer<void>();
    _scrollController = ScrollController();
    _fetchIndicator = FetchIndicator();
    _transactionsLeft = true;
    _isScrollingUp = false;
    _isUpdating = false;

    _scrollController.addListener(_handleScrollEvent);
  }

  @override
  void initState() {
    super.initState();
    _transactionsBloc = BlocProvider.of<TimeFrameBloc>(context);
    _navigationBloc = BlocProvider.of<NavigationBloc>(context);
    _mainScaffold = Scaffold.of(context);

    _transactionsBloc.listen(_handleStateUpdate);
    _navigationBloc.listen(_handleNavigationStateUpdate);
  }

  @override
  void dispose() {
    super.dispose();
    _refreshCompleter?.complete();
    _scrollController.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  void _handleStateUpdate(TimeFrameState state) {
    if (state is TimeFramesLoaded) {
      _handleTransactionsLoadedState(state);
    }
    if (state is TransactionDeleted) {
      _handleTransactionDeletedState(state);
    }
    if (state is TransactionRestored) {
      _handleTransactionRestoredState(state);
    }
    if (state is TimeFramesFetched) {
      _handleTransactionFetched(state);
    }
  }

  void _handleTransactionsLoadedState(TimeFramesLoaded state) {
    setState(() {
      _transactionsKey = GlobalKey<AnimatedListState>();
      _transactions = ListModel<Transaction>(
        _transactionsKey,
        _buildRemovedItem,
        state.timeFrames.reduce(
          (value, element) {
            value.transactions.addAll(element.transactions);
            return value;
          },
        ).transactions,
      );
    });

    _fetchIndicator.setSleeping();
    _completeLoadTransactions();
  }

  void _handleTransactionDeletedState(TransactionDeleted state) {
    var transaction = state.transaction;
    _lastDeletedIndex = _transactions.indexOf(transaction);
    _transactions.remove(_lastDeletedIndex);

    _mainScaffold.removeCurrentSnackBar();
    _mainScaffold.showSnackBar(
      SnackBar(
        content: Text(
          "Deleted Transaction '${transaction.title}'",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            _transactionsBloc.add(
              RestoreTransaction(transaction: transaction),
            );
          },
        ),
      ),
    );
  }

  void _handleTransactionRestoredState(TransactionRestored state) {
    var transaction = state.transaction;
    _transactions.insert(transaction, _lastDeletedIndex);

    _mainScaffold.removeCurrentSnackBar();
    _mainScaffold.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          "Restored Transaction '${transaction.title}'",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  void _handleNavigationStateUpdate(NavigationState state) {
    if (state is SamePage) {
      _handleSamePageState(state);
    }
  }

  void _handleSamePageState(SamePage state) {
    if (_isScrollingUp || _isUpdating || !_scrollController.hasClients) {
      return;
    }

    if (_scrollController.position.pixels ==
        _scrollController.position.minScrollExtent) {
      _refreshIndicatorKey.currentState.show();
      return;
    }

    setState(() {
      _isScrollingUp = true;
    });

    var duration = Duration(milliseconds: 500);
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: duration,
    );

    Timer(duration, () {
      setState(() {
        _isScrollingUp = false;
      });
    });
  }

  void _handleTransactionFetched(TimeFramesFetched state) async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _fetchIndicator.setSleeping();
    });

    if (state.timeFrames.length == 0) {
      _transactionsLeft = false;
      _fetchIndicator.setNoTransactionsLeft();
      return;
    }

    state.timeFrames.forEach((TimeFrame timeFrame) {
      timeFrame.transactions.forEach((Transaction transaction) {
        _transactions.insert(transaction);
      });
    });
  }

  Future<void> _loadTransactions() {
    _isUpdating = true;
    _transactionsBloc.add(LoadTimeFrame());
    return _refreshCompleter.future;
  }

  void _completeLoadTransactions() async {
    await Future.delayed(Duration(milliseconds: 500));
    _mainScaffold.removeCurrentSnackBar();
    _refreshCompleter.complete();
    _isUpdating = false;
    _refreshCompleter = Completer();
  }

  void _handleScrollEvent() async {
    var fetchMoreThreshold = 0.9 * _scrollController.position.maxScrollExtent;
    if (_transactionsLeft &&
        !_fetchIndicator.isFetching() &&
        _scrollController.position.pixels > fetchMoreThreshold) {
      _fetchTransactions();
    }
  }

  void _fetchTransactions() {
    _transactionsBloc.add(
      FetchTimeFrame(
        fetchCount: 10,
        lastTransaction: _transactions[_transactions.length - 1],
      ),
    );
    setState(() {
      _fetchIndicator.setFetching();
    });
  }

  Widget _buildItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    var transaction = _transactions[index];
    return CardItem(transaction, () {
      Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (BuildContext context) =>
              EditTransaction(transaction, _transactionsBloc),
        ),
      );
    }, animation, null);
  }

  Widget _buildRemovedItem(
    Transaction transaction,
    BuildContext context,
    Animation<double> animation,
  ) {
    return CardItem(
      transaction,
      null,
      animation,
      Colors.red,
    );
  }

  Widget build(BuildContext context) {
    if (_transactions == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_transactions.length == 0) {
      return Center(
        child: Text('no time_frame'),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Column(
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            Expanded(
              flex: 9,
              child: Scrollbar(
                child: RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: _loadTransactions,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: <Widget>[
                        AnimatedList(
                          shrinkWrap: true,
                          key: _transactionsKey,
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          initialItemCount: _transactions.length,
                          itemBuilder: _buildItem,
                          physics: NeverScrollableScrollPhysics(),
                        ),
                        _fetchIndicator,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AccountBalance(balance: 10000).formattedBalance,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
