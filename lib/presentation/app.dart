import 'package:flutter/material.dart';
import 'package:unnamed_budgeting_app/presentation/router.dart';
import 'package:unnamed_budgeting_app/presentation/styles.dart';

class UnnamedBudgetingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Router(),
    );
  }
}