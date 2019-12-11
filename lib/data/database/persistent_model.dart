import 'package:unnamed_budgeting_app/data/database/field_config.dart';

abstract class PersistentModel {
  String getTableName();
  List<FieldConfig> getFieldConf();
}