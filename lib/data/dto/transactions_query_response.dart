import 'package:unnamed_budgeting_app/domain/models/transaction_list.dart';

class TransactionsQueryResponse {
  TransactionList transactions;
  int maxTransactions;

  TransactionsQueryResponse(this.transactions, this.maxTransactions);
}
