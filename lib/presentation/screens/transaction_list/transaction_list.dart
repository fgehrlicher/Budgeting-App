import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hunger_preventer/domain/bloc/transaction_list/transaction_list_bloc.dart';
import 'package:hunger_preventer/domain/bloc/transaction_list/transaction_list_state.dart';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  TransactionListBloc _transactionListBloc;

  @override
  void initState() {
    super.initState();
    this._transactionListBloc = BlocProvider.of<TransactionListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionListBloc, TransactionListState>(
      builder: (context, state) {
        if (state is TransactionsEmpty) {
          return Center(
            child: Text('no transactions'),
          );
        }
        if (state is TransactionsLoading) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }

        if (state is TransactionsLoaded) {
          var childen = List<Widget>();
          state.transactions.forEach((element) {
            childen.add(
              Container(
                height: 50,
                color: Colors.amber[100],
                child: Center(child: Text(element.date.toIso8601String())),
              ),
            );
          });
          return ListView(
            padding: const EdgeInsets.all(8),
            children: childen
          );
        }

        return Container();
      },
    );
  }
}
