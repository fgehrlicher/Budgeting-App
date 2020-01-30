import 'package:flutter/material.dart';
import 'package:unnamed_budgeting_app/data/database/field_config.dart';
import 'package:unnamed_budgeting_app/data/database/persistent_model.dart';
import 'package:unnamed_budgeting_app/data/database/sqlite_types.dart';

class TransactionCategory implements PersistentModel {
  static const String TABLE_NAME = "usertransactioncategory";

  int id;
  static const String ID_NAME = "id";
  static const String ID_CONFIG = SqliteTypes.PRIMARY_KEY;

  String title;
  static const String TITLE_NAME = "title";
  static const String TITLE_CONFIG = SqliteTypes.TEXT;

  IconData iconData;
  static const String ICON_DATA_NAME = "icondata";
  static const String ICON_DATA_CONFIG = SqliteTypes.INT;

  Color color;
  static const String COLOR_NAME = "color";
  static const String COLOR_CONFIG = SqliteTypes.TEXT;

  TransactionCategory({this.id, this.title, this.iconData, this.color});

  factory TransactionCategory.fromId(int id) {
    return initialTransactionCategories.firstWhere((element) => element.id == id);
  }

  @override
  String get tableName {
    return TABLE_NAME;
  }

  @override
  List<FieldConfig> get fieldConf {
    return [
      FieldConfig(ID_NAME, ID_CONFIG),
      FieldConfig(TITLE_NAME, TITLE_CONFIG),
      FieldConfig(ICON_DATA_NAME, ICON_DATA_CONFIG),
      FieldConfig(COLOR_NAME, COLOR_CONFIG),
    ];
  }

  TransactionCategory.fromMap(Map<String, dynamic> data) {
    id = data[ID_NAME];
    title = data[TITLE_NAME];
  }

  Map<String, dynamic> toMap() {
    var map = {
      ID_NAME: id,
      TITLE_NAME: title,
    };

    map.removeWhere((key, value) => value == null);
    return map;
  }

}

List<TransactionCategory> initialTransactionCategories = [
  TransactionCategory(
    id: 1,
    title: "Salary",
    iconData: Icons.attach_money,
    color: Colors.orangeAccent,
  ),
  TransactionCategory(
    id: 2,
    title: "Food & Groceries",
    iconData: Icons.fastfood,
    color: Colors.tealAccent,
  ),
  TransactionCategory(
    id: 3,
    title: "Shopping",
    iconData: Icons.local_grocery_store,
    color: Colors.purpleAccent,
  ),
  TransactionCategory(
    id: 4,
    title: "Cash withdrawal",
    iconData: Icons.account_balance,
    color: Colors.amberAccent,
  ),
  TransactionCategory(
    id: 5,
    title: "Transport & car",
    iconData: Icons.directions_bus,
    color: Colors.blueAccent,
  ),
  TransactionCategory(
    id: 6,
    title: "Online Services",
    iconData: Icons.devices,
    color: Colors.deepOrange,
  ),
];
