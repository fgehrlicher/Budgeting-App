import 'package:flutter/material.dart';
import 'package:hunger_preventer/presentation/screens/home/home_screen.dart';
import 'package:hunger_preventer/presentation/styles.dart';

class HungerPreventerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}