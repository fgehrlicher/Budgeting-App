import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_event.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_state.dart';
import 'package:unnamed_budgeting_app/domain/models/acount_balance.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction.dart';
import 'package:unnamed_budgeting_app/presentation/screens/edit_transaction/edit_transaction.dart';
import 'package:unnamed_budgeting_app/presentation/screens/transactions/card_item.dart';
import 'package:unnamed_budgeting_app/presentation/screens/transactions/fetch_indicator.dart';
import 'package:unnamed_budgeting_app/presentation/widgets/list_model.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> with AutomaticKeepAliveClientMixin {
  TransactionsBloc _transactionsBloc;
  Completer<void> _refreshCompleter;
  ScrollController _scrollController;

  ListModel<Transaction> _transactions;
  GlobalKey<AnimatedListState> _transactionsKey =
      GlobalKey<AnimatedListState>();
  int _lastDeletedIndex;
  ScaffoldState _mainScaffold;
  FetchIndicator _fetchIndicator;

  _TransactionsState() {
    _refreshCompleter = Completer<void>();
    _scrollController = ScrollController();
    _fetchIndicator = FetchIndicator();

    _scrollController.addListener(_handleScrollEvent);
  }

  @override
  void initState() {
    super.initState();
    _transactionsBloc = BlocProvider.of<TransactionsBloc>(context);
    _mainScaffold = Scaffold.of(context);

    _transactionsBloc.listen(_handleStateUpdate);
  }

  @override
  void dispose() {
    _refreshCompleter?.complete();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  void _handleStateUpdate(TransactionsState state) {
    if (state is TransactionsLoaded) {
      _handleTransactionsLoadedState(state);
    }
    if (state is TransactionDeleted) {
      _handleTransactionDeletedState(state);
    }
    if (state is TransactionRestored) {
      _handleTransactionRestoredState(state);
    }
    if (state is TransactionFetched) {
      _handleTransactionFetched(state);
    }
  }

  void _handleTransactionsLoadedState(TransactionsLoaded state) {
    setState(() {
      _transactionsKey = GlobalKey<AnimatedListState>();
      _transactions = ListModel<Transaction>(
        _transactionsKey,
        _buildRemovedItem,
        state.transactions,
      );
    });

    _completeFetchTransactions();
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
              RestoreTransaction(transaction),
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

  void _handleTransactionFetched(TransactionFetched state) async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      _fetchIndicator.setSleeping();
    });
    state.transactions.forEach((Transaction transaction) {
      _transactions.insert(transaction);
    });
  }

  Future<void> _loadTransactions() {
    _transactionsBloc.add(LoadTransactions());
    return _refreshCompleter.future;
  }

  void _completeFetchTransactions() async {
    await Future.delayed(Duration(milliseconds: 500));
    _mainScaffold.removeCurrentSnackBar();
    _refreshCompleter.complete();
    _refreshCompleter = Completer();
  }

  void _handleScrollEvent() async {
    var fetchMoreThreshold = 0.9 * _scrollController.position.maxScrollExtent;
    if (scrollController.position.pixels > fetchMoreThreshold) {
      _fetchTransactions();
    }
  }

  void _fetchTransactions() {
    _transactionsBloc.add(
      FetchTransactions(
        20,
        _transactions[_transactions.length - 1],
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
        child: Text('no transactions'),
      );
    }

    return SafeArea(
      child: Column(
        verticalDirection: VerticalDirection.up,
        children: <Widget>[
          Expanded(
            flex: 9,
            child: Scrollbar(
              child: RefreshIndicator(
                onRefresh: _loadTransactions,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: <Widget>[
                      AnimatedList(
                        shrinkWrap: true,
                        key: _transactionsKey,
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
            child: Container(
              padding: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    offset: Offset(0.0, 6.0),
                    color: Color(0xffEDEDED),
                    blurRadius: 8.0,
                  ),
                ],
                color: Colors.white70,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AccountBalance(balance: 10000).formattedBalance,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
