import 'package:flutter/material.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction_category.dart';

const List<TransactionCategory> transactionCategories = [
  TransactionCategory(
    id: 1,
    title: "Salary",
    iconData: Icons.attach_money,
    backgroundColor: Colors.orangeAccent,
    textColor: Colors.white,
  ),
  TransactionCategory(
    id: 2,
    title: "Food & Groceries",
    iconData: Icons.fastfood,
    backgroundColor: Colors.tealAccent,
    textColor: Colors.white,
  ),
  TransactionCategory(
    id: 3,
    title: "Shopping",
    iconData: Icons.local_grocery_store,
    backgroundColor: Colors.purpleAccent,
    textColor: Colors.white,
  ),
  TransactionCategory(
    id: 4,
    title: "Cash withdrawal",
    iconData: Icons.account_balance,
    backgroundColor: Colors.amberAccent,
    textColor: Colors.white,
  ),
  TransactionCategory(
    id: 5,
    title: "Transport & car",
    iconData: Icons.directions_bus,
    backgroundColor: Colors.blueAccent,
    textColor: Colors.white,
  ),
  TransactionCategory(
    id: 6,
    title: "Online Services",
    iconData: Icons.devices,
    backgroundColor: Colors.deepOrange,
    textColor: Colors.white,
  ),
];
