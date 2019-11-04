class SchemaProvider {
  static const String TRANSACTION_TABLE_NAME = "usertransaction";

  static String getDatabaseSchema() {
    return """ 
    CREATE TABLE $TRANSACTION_TABLE_NAME(
      id INT PRIMARY KEY,
      date INT NOT NULL,
      amount INT NOT NULL,
      transaction_type INT,
      iban TEXT,
      bic TEXT
    )
    """;
  }
}

