import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:hunger_preventer/data/app_state.dart';
import 'package:hunger_preventer/data/database/database_provider.dart';
import 'package:hunger_preventer/data/repositories/transaction_repository.dart';
import 'package:hunger_preventer/screens/home/home.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  var appState = AppState();
  runApp(
    ScopedModel<AppState>(
      model: appState,
      child: CupertinoApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    ),
  );
}
