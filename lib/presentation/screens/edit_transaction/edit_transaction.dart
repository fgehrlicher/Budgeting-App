import 'package:flutter/material.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction.dart';

class EditTransaction extends StatelessWidget {
  final Transaction _transaction;
  final _formKey = GlobalKey<FormState>();

  EditTransaction(this._transaction);

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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: RaisedButton.icon(
                              color: Colors.red[400],
                              icon: Icon(
                                Icons.delete_forever,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  Navigator.pop(context);
                                }
                              },
                              label: Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: RaisedButton.icon(
                              color: Colors.green[400],
                              icon: Icon(
                                Icons.save,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  Navigator.pop(context);
                                }
                              },
                              label: Text(
                                'Save',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
