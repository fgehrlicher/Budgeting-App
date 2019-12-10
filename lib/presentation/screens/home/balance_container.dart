import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class BalanceContainer extends StatelessWidget {
  final String headline;
  final String body;
  final RefreshCallback refreshCallback;

  BalanceContainer(
      {@required this.headline,
      @required this.body,
      @required this.refreshCallback});

  @override
  Widget build(BuildContext context) {
    List<Widget> columnWidgets = List();

    var topSpacerSize = MediaQuery.of(context).size.height * 0.4;
    columnWidgets.add(Container(height: topSpacerSize));

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
      child: RefreshIndicator(
        onRefresh: refreshCallback,
        child: ListView(
          children: columnWidgets,
        ),
      ),
    );
  }
}
