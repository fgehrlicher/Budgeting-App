import 'dart:ui';
import 'package:flutter/material.dart';

class BalanceContainer extends StatelessWidget {
  static const String HEADLINE = "Available ";
  final String balance;

  BalanceContainer(this.balance);

  @override
  Widget build(BuildContext context) {
    List<Widget> columnWidgets = [
      Text(
        HEADLINE,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Color(0xff0089BA),
        ),
      )
    ];

    if (balance != null) {
      columnWidgets.add(
        Text(
          balance,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: columnWidgets,
    );
  }
}
