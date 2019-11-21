import 'package:hunger_preventer/data/orm/field_type.dart';

class OrmConfig {
  final String fieldName;
  final FieldType fieldType;
  final bool nullable;

  const OrmConfig({this.fieldName, this.fieldType, this.nullable = true});
}
