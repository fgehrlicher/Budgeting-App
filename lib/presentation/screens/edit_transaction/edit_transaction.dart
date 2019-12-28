import 'package:flutter/material.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/transactions/transactions_event.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction.dart';

class EditTransaction extends StatelessWidget {
  final Transaction _transaction;
  final TransactionsBloc _transactionsBloc;
  final _formKey = GlobalKey<FormState>();

  EditTransaction(this._transaction, this._transactionsBloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          _transaction.title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            tooltip: "Delete Transaction",
            icon: Icon(
              Icons.delete,
              color: Colors.black,
            ),
            onPressed: () {
              _transactionsBloc.add(DeleteTransaction(_transaction));
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Text("Transaction Title"),
                        ),
                        Expanded(
                          flex: 7,
                          child: TextFormField(
                            initialValue: _transaction.title,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
