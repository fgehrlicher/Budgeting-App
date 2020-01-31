import 'package:flutter/material.dart';
import 'package:unnamed_budgeting_app/data/database/field_config.dart';
import 'package:unnamed_budgeting_app/data/database/persistent_model.dart';
import 'package:unnamed_budgeting_app/data/database/sqlite_types.dart';
import 'package:unnamed_budgeting_app/domain/models/icon.dart' as iconAdapter;

class TransactionCategory implements PersistentModel {
  static const String TABLE_NAME = "usertransactioncategory";

  int id;
  static const String ID_NAME = "id";
  static const String ID_CONFIG = SqliteTypes.PRIMARY_KEY;

  String title;
  static const String TITLE_NAME = "title";
  static const String TITLE_CONFIG = SqliteTypes.TEXT;

  iconAdapter.Icon icon;
  static const String ICON_NAME = "icon";
  static const String ICON_CONFIG = SqliteTypes.INT;

  Color color;
  static const String COLOR_NAME = "color";
  static const String COLOR_CONFIG = SqliteTypes.INT;

  TransactionCategory({this.id, this.title, this.icon, this.color});

  @override
  String get tableName {
    return TABLE_NAME;
  }

  @override
  String get idFieldName {
    return ID_NAME;
  }

  @override
  int get idField {
    return id;
  }

  @override
  List<FieldConfig> get fieldConf {
    return [
      FieldConfig(ID_NAME, ID_CONFIG),
      FieldConfig(TITLE_NAME, TITLE_CONFIG),
      FieldConfig(ICON_NAME, ICON_CONFIG),
      FieldConfig(COLOR_NAME, COLOR_CONFIG),
    ];
  }

  TransactionCategory.fromMap(Map<String, dynamic> data) {
    id = data[ID_NAME];
    title = data[TITLE_NAME];
    if (data.containsKey(ICON_NAME)) {
      var id = data[ICON_NAME];
      icon = iconAdapter.Icon.fromId(id);
    }
    if (data.containsKey(COLOR_NAME)) {
      color = Color(data[COLOR_NAME]);
    }
  }

  Map<String, dynamic> toMap() {
    var map = {
      ID_NAME: id,
      TITLE_NAME: title,
      ICON_NAME: icon?.id,
      COLOR_NAME: color?.value,
    };

    map.removeWhere((key, value) => value == null);
    return map;
  }
}

List<TransactionCategory> initialTransactionCategories = [
  TransactionCategory(
    id: 1,
    title: "Salary",
    icon: iconAdapter.Icon.fromId(1),
    color: Colors.orangeAccent,
  ),
  TransactionCategory(
    id: 2,
    title: "Food & Groceries",
    icon: iconAdapter.Icon.fromId(16),
    color: Colors.tealAccent,
  ),
  TransactionCategory(
    id: 3,
    title: "Shopping",
    icon: iconAdapter.Icon.fromId(17),
    color: Colors.purpleAccent,
  ),
  TransactionCategory(
    id: 4,
    title: "Cash withdrawal",
    icon: iconAdapter.Icon.fromId(2),
    color: Colors.amberAccent,
  ),
  TransactionCategory(
    id: 5,
    title: "Transport & car",
    icon: iconAdapter.Icon.fromId(18),
    color: Colors.blueAccent,
  ),
  TransactionCategory(
    id: 6,
    title: "Online Services",
    icon: iconAdapter.Icon.fromId(19),
    color: Colors.deepOrange,
  ),
];
