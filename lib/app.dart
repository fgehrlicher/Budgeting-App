import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: Container(),
    ),
  );
}
