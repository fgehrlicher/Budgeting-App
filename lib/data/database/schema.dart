import 'package:unnamed_budgeting_app/data/database/persistent_model.dart';

class SchemaProvider {

  static String getSchema(PersistentModel model) {
    var schema = "CREATE TABLE ${model.getTableName()}(";
    var transactionConf = model.getFieldConf();

    for (int i = 0; i < transactionConf.length; i++) {
      schema += transactionConf[i].toString();
      if (i < transactionConf.length - 1) {
        schema += ",";
      }
    }
    schema += ")";

    return schema;
  }
}
