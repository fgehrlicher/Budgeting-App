import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unnamed_budgeting_app/data/database/database_provider.dart';
import 'package:unnamed_budgeting_app/data/repositories/account_balance_repository.dart';
import 'package:unnamed_budgeting_app/data/repositories/transaction_repository.dart';
import 'package:unnamed_budgeting_app/domain/models/acount_balance.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction_list.dart';
import 'package:unnamed_budgeting_app/presentation/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  TransactionRepository(DatabaseProvider.database).insertMultiple(
    TransactionList()
      ..addAll(
        [
          Transaction(
              date: DateTime.parse("2019-10-08 10:00:00"), amount: 1000, id: 1),
          Transaction(
              date: DateTime.parse("2019-13-08 10:00:00"), amount: -100, id: 2),
          Transaction(
              date: DateTime.parse("2019-20-08 10:00:00"), amount: -200, id: 3),
          Transaction(
              date: DateTime.parse("2019-29-08 10:00:00"), amount: -50, id: 4),
          Transaction(
              date: DateTime.parse("2019-01-09 10:00:00"), amount: 1000, id: 5),
        ],
      ),
  );

  AccountBalanceRepository(DatabaseProvider.database).insertOne(
    AccountBalance(id: 1, date: DateTime.parse("2019-01-08 10:00:00"), balance: 10),
  );

  runApp(UnnamedBudgetingApp());
}
