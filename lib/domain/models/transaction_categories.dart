import 'package:flutter/material.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction_category.dart';

const List<TransactionCategory> transactionCategories = [
  TransactionCategory(1, "Salary", Icons.attach_money),
  TransactionCategory(2, "Food & Groceries", Icons.fastfood),
  TransactionCategory(3, "Shopping", Icons.local_grocery_store),
  TransactionCategory(4, "Cash withdrawal", Icons.account_balance),
  TransactionCategory(5, "Transport & car", Icons.directions_bus),
  TransactionCategory(6, "Online Services", Icons.devices),
];