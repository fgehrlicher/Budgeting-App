class SchemaProvider {
  static String getDatabaseSchema() {
    return """ 
    CREATE TABLE transaction(
      id INT PRIMARY KEY,
      date INT NOT NULL,
      amount INT NOT NULL,
      transaction_type INT,
      iban TEXT,
      bic TEXT
    );
    
    INSERT INTO transaction (date,amount,transaction_type,iban,bic)
    VALUES 
       (1571426934,100,1,"12321332-de","ASD22332"),
       (1571426930,100,1,"12321332-de","ASD22332"),
       (1571426920,200,NULL,"12321332-de","ASD22332"),
       (1571426910,-100,NULL,"12321332-de","ASD22332"),
    """;
  }
}

