import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_event.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_state.dart';
import 'package:unnamed_budgeting_app/domain/models/acount_balance.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction_list.dart';
import 'package:unnamed_budgeting_app/presentation/screens/edit_transaction/edit_transaction.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  TransactionsBloc _transactionsBloc;
  TransactionList _transactionList;
  Completer<void> _refreshCompleter;

  _TransactionsState() {
    _refreshCompleter = Completer<void>();
  }

  @override
  void initState() {
    super.initState();
    _transactionsBloc = BlocProvider.of<TransactionsBloc>(context);
    _transactionsBloc.listen(_handleStateUpdate);
  }

  RefreshCallback _fetchTransactions() {
    return () {
      _transactionsBloc.add(FetchTransactions());
      return _refreshCompleter.future;
    };
  }

  _handleStateUpdate(TransactionsState state) {
    if (state is TransactionsLoaded) {
      _completeRefresh();
      setState(() {
        _transactionList = state.transactions;
      });
    }
    if (state is TransactionsInitialLoading) {
      Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is TransactionsEmpty) {
      Center(
        child: Text('no transactions'),
      );
    }
  }

  @override
  void dispose() {
    _refreshCompleter?.complete();
    super.dispose();
  }

  void _completeRefresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    _refreshCompleter?.complete();
    _refreshCompleter = Completer();
  }

  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var childen = List<Widget>();
        if (_transactionList != null) {
          _transactionList.forEach((transaction) {
            childen.add(
              Card(
                child: ListTile(
                  leading: transaction.category != null
                      ? Icon(
                          transaction.category.iconData,
                          size: 30,
                        )
                      : Container(
                          height: 30,
                          width: 30,
                        ),
                  title: Text(
                    transaction.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    transaction.getFormattedBalance(),
                    style: TextStyle(
                      color: transaction.amount > 0 ? Colors.green : Colors.red,
                      fontSize: 15,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (BuildContext context) =>
                            EditTransaction(transaction, _transactionsBloc),
                      ),
                    );
                  },
                ),
              ),
            );
          });

          return SafeArea(
            child: Column(
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                Expanded(
                  flex: 9,
                  child: RefreshIndicator(
                    onRefresh: _fetchTransactions(),
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      children: childen,
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
                      constraints:
                          BoxConstraints(minWidth: constraints.maxWidth),
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
        }
        return Container();
      },
    );
  }
}
