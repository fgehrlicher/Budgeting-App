import 'package:flutter/material.dart';
import 'package:unnamed_budgeting_app/domain/model/time_frame.dart';
import 'package:unnamed_budgeting_app/domain/model/transaction.dart';
import 'package:unnamed_budgeting_app/presentation/screens/transactions/edit_transaction/edit_transaction.dart';
import 'package:unnamed_budgeting_app/presentation/screens/transactions/transaction_list/card_item.dart';

class TimeFrameContainer extends StatefulWidget {
  final TimeFrame _timeFrame;

  TimeFrameContainer(this._timeFrame);

  @override
  State createState() => _TimeFrameContainerState(_timeFrame);
}

class _TimeFrameContainerState extends State<TimeFrameContainer> {
  final TimeFrame _timeFrame;

  _TimeFrameContainerState(this._timeFrame);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: _timeFrame.transactions.map<Widget>((Transaction transaction) {
        return CardItem(
          transaction,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (BuildContext context) => EditTransaction(transaction),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
