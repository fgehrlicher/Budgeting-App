import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_state.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  TransactionsBloc _transactionsBloc;

  @override
  void initState() {
    super.initState();
    this._transactionsBloc = BlocProvider.of<TransactionsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        if (state is TransactionsEmpty) {
          return Center(
            child: Text('no transactions'),
          );
        }
        if (state is TransactionsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is TransactionsLoaded) {
          var childen = List<Widget>();
          state.transactions.forEach((element) {
            childen.add(
              Card(
                child: ListTile(
                  title: const Text("Transaction"),
                  subtitle: Text(element.amount.toString()),
                ),
              ),
            );
          });

          return ListView(padding: const EdgeInsets.all(8), children: childen, reverse: true,);
        }

        return Container();
      },
    );
  }
}
