import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unnamed_budgeting_app/data/database/database_provider.dart';
import 'package:unnamed_budgeting_app/data/repositories/account_balance_repository.dart';
import 'package:unnamed_budgeting_app/data/repositories/transaction_repository.dart';
import 'package:unnamed_budgeting_app/domain/models/acount_balance.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction_categories.dart';
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
            title: "Salary payment",
            category: transactionCategories[0],
            date: DateTime.parse("2019-01-12 10:00:00"),
            amount: 280000,
            id: 1,
          ),
          Transaction(
            title: "Rent",
            date: DateTime.parse("2019-02-12 09:00:00"),
            amount: -120000,
            id: 2,
          ),
          Transaction(
            title: "Cash withdrawal",
            category: transactionCategories[3],
            date: DateTime.parse("2019-05-12 15:00:00"),
            amount: -20000,
            id: 3,
          ),
          Transaction(
            title: "Netflix",
            category: transactionCategories[5],
            date: DateTime.parse("2019-12-12 15:00:00"),
            amount: -1000,
            id: 4,
          ),
          Transaction(
            title: "Spotify",
            category: transactionCategories[5],
            date: DateTime.parse("2019-12-12 23:00:00"),
            amount: -1000,
            id: 5,
          ),
          Transaction(
            title: "Bar",
            date: DateTime.parse("2019-13-12 02:32:00"),
            amount: -7000,
            id: 6,
          ),
          Transaction(
            title: "Grocery Shopping",
            category: transactionCategories[1],
            date: DateTime.parse("2019-20-12 12:00:00"),
            amount: -15000,
            id: 7,
          ),
          Transaction(
            title: "Water and Electricity",
            date: DateTime.parse("2019-23-12 12:00:00"),
            amount: -20000,
            id: 8,
          ),
          Transaction(
            title: "Loan",
            date: DateTime.parse("2019-23-12 12:00:00"),
            amount: -12310,
            id: 9,
          ),
        ],
      ),
  );

  AccountBalanceRepository(DatabaseProvider.database).insertOne(
    AccountBalance(
        id: 1, date: DateTime.parse("2019-28-11 10:00:00"), balance: 23200),
  );

  runApp(UnnamedBudgetingApp());
}
