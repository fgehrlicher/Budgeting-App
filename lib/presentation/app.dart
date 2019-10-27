import 'package:flutter/cupertino.dart';
import 'package:hunger_preventer/presentation/screens/home/home_screen.dart';
import 'package:hunger_preventer/styles.dart';

class HungerPreventerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: HomeScreen(),
    );
  }
}