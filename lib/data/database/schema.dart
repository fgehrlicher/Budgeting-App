import 'package:hunger_preventer/domain/models/balance_snapshot.dart';
import 'package:hunger_preventer/domain/models/transaction.dart';

class SchemaProvider {
  static String getTransactionTableSchema() {
    var schema = "CREATE TABLE ${Transaction.TABLE_NAME}(";
    var transactionConf = Transaction.getFieldConf();

    for (int i = 0; i < transactionConf.length; i++) {
      schema += transactionConf[i].toString();
      if (i < transactionConf.length - 1) {
        schema += ",";
      }
    }
    schema += ")";

    return schema;
  }

  static String getAcountBalanceSnapshotTableSchema() {
    return """ 
    CREATE TABLE ${AccountBalanceSnapshot.TABLE_NAME}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date INT NOT NULL,
      balance INT NOT NULL
    )
    """;
  }
}
