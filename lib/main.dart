import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hunger_preventer/presentation/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(HungerPreventerApp());
}
