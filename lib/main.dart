import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unnamed_budgeting_app/dummy_data.dart';
import 'package:unnamed_budgeting_app/presentation/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  DummyData()..insertDummyData();

  runApp(UnnamedBudgetingApp());
}
