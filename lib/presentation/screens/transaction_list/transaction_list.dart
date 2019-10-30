import 'package:flutter/cupertino.dart';
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
    builder: (context, state) {}
  }

}