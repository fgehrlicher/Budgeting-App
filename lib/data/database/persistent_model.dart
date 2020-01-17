import 'package:unnamed_budgeting_app/data/database/field_config.dart';

abstract class PersistentModel {
  String get tableName;
  List<FieldConfig> get fieldConf;
}
