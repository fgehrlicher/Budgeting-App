import 'package:hunger_preventer/data/transaction_repository.dart';
import 'package:scoped_model/scoped_model.dart';

class AppState extends Model {

  TransactionRepository _transactionRepository;

  AppState(this._transactionRepository);
}