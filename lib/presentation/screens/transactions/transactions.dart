import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_event.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_state.dart';
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
                state.transactions.forEach((element) {
                  childen.add(
                    Card(
                      child: ListTile(
                        leading: element.category != null
                            ? Icon(
                                element.category.iconData,
                                size: 30,
                              )
                            : Container(
                                height: 30,
                                width: 30,
                              ),
                        title: Text(element.title,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          element.getFormattedBalance(),
                          style: TextStyle(
                            color:
                                element.amount > 0 ? Colors.green : Colors.red,
                            fontSize: 15,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (BuildContext context) =>
                                  EditTransaction(element),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                });

                return RefreshIndicator(
                  onRefresh: _getRefreshCallback(),
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: childen,
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
