import 'package:unnamed_budgeting_app/domain/model/transaction_list.dart';

class TransactionsQueryResponse {
  TransactionList transactions;
  int maxTransactions;

  TransactionsQueryResponse(this.transactions, this.maxTransactions);
}
