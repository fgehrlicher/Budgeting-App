import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/time_frame/time_frame_bloc.dart';
import 'package:unnamed_budgeting_app/domain/bloc/time_frame/time_frame_event.dart';
import 'package:unnamed_budgeting_app/domain/model/transaction.dart';

class EditTransaction extends StatelessWidget {
  final Transaction _transaction;
  final _formKey = GlobalKey<FormState>();

  EditTransaction(this._transaction);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_down,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              IconButton(
                tooltip: "Delete Transaction",
                icon: Icon(
                  Icons.delete,
                ),
                onPressed: () {
                  BlocProvider.of<TimeFrameBloc>(context)
                      .add(DeleteTransaction(transaction: _transaction));
                  Navigator.pop(context);
                },
              ),
            ],
            expandedHeight: 150.0,
            floating: true,
            pinned: true,
            snap: true,
            backgroundColor: _transaction.category?.color ?? Colors.grey,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Container(
                color: _transaction.category?.color ?? Colors.grey,
              ),
            ),
          ),
          new SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              initialValue: _transaction.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                  hintText: 'Transaction Title'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              initialValue:
                                  _transaction.category?.title ?? "No Category",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              initialValue: _transaction.formattedBalance,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              initialValue: _transaction.date.toIso8601String(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
