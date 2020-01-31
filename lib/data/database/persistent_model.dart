import 'package:unnamed_budgeting_app/data/database/field_config.dart';

abstract class PersistentModel {
  String get tableName;

  String get idFieldName;

  int get idField;

  List<FieldConfig> get fieldConf;

  Map<String, dynamic> toMap();
}
