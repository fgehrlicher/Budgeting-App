import 'package:flutter/material.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction_category.dart';

const List<TransactionCategory> transactionCategories = [
  TransactionCategory(
    1,
    "Salary",
    Icons.attach_money,
    const AssetImage("assets/images/transaction_salary.png"),
  ),
  TransactionCategory(
    2,
    "Food & Groceries",
    Icons.fastfood,
    const AssetImage(""),
  ),
  TransactionCategory(
    3,
    "Shopping",
    Icons.local_grocery_store,
    const AssetImage(""),
  ),
  TransactionCategory(
    4,
    "Cash withdrawal",
    Icons.account_balance,
    const AssetImage(""),
  ),
  TransactionCategory(
    5,
    "Transport & car",
    Icons.directions_bus,
    const AssetImage(""),
  ),
  TransactionCategory(
    6,
    "Online Services",
    Icons.devices,
    const AssetImage(""),
  ),
];
