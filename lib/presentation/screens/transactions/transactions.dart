import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_event.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_state.dart';
import 'package:unnamed_budgeting_app/domain/models/acount_balance.dart';
import 'package:unnamed_budgeting_app/presentation/screens/edit_transaction/edit_transaction.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  TransactionsBloc _transactionsBloc;
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    this._transactionsBloc = BlocProvider.of<TransactionsBloc>(context);
    _refreshCompleter = Completer<void>();
  }

  RefreshCallback _getRefreshCallback() {
    return () {
      _transactionsBloc.add(FetchTransactions());
      return _refreshCompleter.future;
    };
  }

  Widget build(BuildContext context) {
    return BlocListener<TransactionsBloc, TransactionsState>(
      listener: (context, state) {
        if (state is TransactionsLoaded) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
        }
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return BlocBuilder<TransactionsBloc, TransactionsState>(
            builder: (context, state) {
              if (state is TransactionsInitialLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is TransactionsEmpty) {
                return Center(
                  child: Text('no transactions'),
                );
              }

              if (state is TransactionsLoaded) {
                var childen = List<Widget>();
                state.transactions.forEach((transaction) {
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
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          transaction.getFormattedBalance(),
                          style: TextStyle(
                            color:
                                transaction.amount > 0 ? Colors.green : Colors.red,
                            fontSize: 15,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (BuildContext context) =>
                                  EditTransaction(transaction),
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
                          onRefresh: _getRefreshCallback(),
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
                              AccountBalance(balance: 10000)
                                  .getFormattedBalance(),
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
        },
      ),
    );
  }
}
