import 'package:hunger_preventer/data/database/field_config.dart';

abstract class PersistentModel {
  String getTableName();
  List<FieldConfig> getFieldConf();
}