import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hunger_preventer/data/database/database_provider.dart';
import 'package:hunger_preventer/data/repositories/transaction_repository.dart';
import 'package:hunger_preventer/domain/models/transaction.dart';
import 'package:hunger_preventer/domain/models/transaction_list.dart';
import 'package:hunger_preventer/presentation/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  var transactions = TransactionRepository(DatabaseProvider.database);
  transactions.insertMultiple(TransactionList()
    ..addAll([
      Transaction(
        date: DateTime.parse("2019-01-08 10:00:00"), amount: 1000, id: 1
      ),
      Transaction(
        date: DateTime.parse("2019-13-08 10:00:00"), amount: -100, id: 2
      ),
      Transaction(
        date: DateTime.parse("2019-20-08 10:00:00"), amount: -200, id: 3
      ),
      Transaction(
        date: DateTime.parse("2019-29-08 10:00:00"), amount: -50, id: 4
      ),
      Transaction(
        date: DateTime.parse("2019-01-09 10:00:00"), amount: 1000, id: 5
      ),
    ]));

  runApp(HungerPreventerApp());
}
