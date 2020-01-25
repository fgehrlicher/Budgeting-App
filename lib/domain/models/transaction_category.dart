import 'package:flutter/material.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction_categories.dart';

class TransactionCategory {
  final int id;
  final String title;
  final IconData iconData;
  final Color backgroundColor;

  const TransactionCategory({this.id, this.title, this.iconData, this.backgroundColor});

  factory TransactionCategory.fromId(int id) {
    return transactionCategories.firstWhere((element) => element.id == id);
  }
}
