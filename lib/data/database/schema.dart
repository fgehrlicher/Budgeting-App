import 'package:hunger_preventer/domain/models/balance_snapshot.dart';
import 'package:hunger_preventer/domain/models/transaction.dart';

class SchemaProvider {

  static String getTransactionTableSchema() {
    return """ 
    CREATE TABLE ${Transaction.TABLE_NAME}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date INT NOT NULL,
      amount INT NOT NULL,
      transaction_type INT,
      iban TEXT,
      bic TEXT
    )
    """;
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

