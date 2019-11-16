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
        DateTime.parse("2019-11-08 10:00:00"), 1000, 1
      ),
      Transaction(
        DateTime.parse("2019-11-09 10:00:00"), -100, 2
      ),
      Transaction(
        DateTime.parse("2019-11-11 10:00:00"), -500, 3
      ),
      Transaction(
        DateTime.parse("2019-11-12 10:00:00"), -300, 4
      ),
      Transaction(
        DateTime.parse("2019-11-13 10:00:00"), -100, 5
      ),
    ]));

  runApp(HungerPreventerApp());
}
