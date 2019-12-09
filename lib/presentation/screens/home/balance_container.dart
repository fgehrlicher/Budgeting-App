import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BalanceContainer extends StatelessWidget {
  final String headline;
  final String body;

  BalanceContainer({this.headline, this.body});

  @override
  Widget build(BuildContext context) {
    List<Widget> columnWidgets = [];

    if (headline != null) {
      columnWidgets.add(
        Text(
          headline,
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.amber[800]),
          textAlign: TextAlign.center,
        ),
      );
    }
    if (body != null) {
      columnWidgets.add(
        Text(
          body,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: columnWidgets,
        ),
      ),
    );
  }
}
