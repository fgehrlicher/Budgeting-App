class SchemaProvider {
  static const String TRANSACTION_TABLE_NAME = "usertransaction";
  static const String ACCOUNT_BALANCE_SNAPSHOT_TABLE_NAME = "accountbalancesnapshot";

  static String getTransactionTableSchema() {
    return """ 
    CREATE TABLE $TRANSACTION_TABLE_NAME(
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
    CREATE TABLE $ACCOUNT_BALANCE_SNAPSHOT_TABLE_NAME(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date INT NOT NULL,
      balance INT NOT NULL
    )
    """;
  }
}

