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
import 'package:unnamed_budgeting_app/presentation/widgets/list_model.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  TransactionsBloc _transactionsBloc;
  Completer<void> _refreshCompleter;
  ListModel<Transaction> _transactions;
  final GlobalKey<AnimatedListState> _transactionsKey = GlobalKey<AnimatedListState>();

  _TransactionsState() {
    _refreshCompleter = Completer<void>();
  }

  @override
  void initState() {
    super.initState();
    _transactionsBloc = BlocProvider.of<TransactionsBloc>(context);
    _transactionsBloc.listen(_handleStateUpdate);
  }

  void _handleStateUpdate(TransactionsState state) {
    if (state is TransactionsLoaded) {
      _completeFetchTransactions();
      setState(() {
        _transactions = ListModel<Transaction>(
          listKey: _transactionsKey,
          initialItems: state.transactions,
          removedItemBuilder: _buildRemovedItem,
        );
      });
    }
    if (state is TransactionDeleted) {
      _transactions.removeAt(_transactions.indexOf(state.transaction));
    }
  }

  RefreshCallback _fetchTransactions() {
    return () {
      _transactionsBloc.add(FetchTransactions());
      return _refreshCompleter.future;
    };
  }

  void _completeFetchTransactions() async {
    await Future.delayed(Duration(milliseconds: 500));
    _refreshCompleter?.complete();
    _refreshCompleter = Completer();
  }

  @override
  void dispose() {
    _refreshCompleter?.complete();
    super.dispose();
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    var transaction = _transactions[index];
    return CardItem(
      transaction,
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) =>
                EditTransaction(transaction, _transactionsBloc),
          ),
        );
      },
      animation,
    );
  }

  Widget _buildRemovedItem(Transaction transaction, BuildContext context,
      Animation<double> animation) {
    return CardItem(
      transaction,
      null,
      animation,
    );
  }

  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
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
                child: RefreshIndicator(
                  onRefresh: _fetchTransactions(),
                  child: AnimatedList(
                    key: _transactionsKey,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    initialItemCount: _transactions.length,
                    itemBuilder: _buildItem,
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
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: Text(
                      AccountBalance(balance: 10000).getFormattedBalance(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
