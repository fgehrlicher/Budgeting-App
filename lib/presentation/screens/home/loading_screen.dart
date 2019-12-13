import 'dart:async';

import 'package:flutter/cupertino.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  static const String HEADLINE = "Available ";
  static const Text loadingBalance = Text(
    " --.-- €",
    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,
  );

  int _dotCount;

  @override
  void initState() {
    super.initState();

    _dotCount = 0;
    Timer.periodic(Duration(milliseconds: 100), (Timer t) => _tick());
  }

  void _tick() {
    setState(() {
      _dotCount = _dotCount >= 3 ? 0 : _dotCount + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Loading " + ("." * _dotCount),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xff0089BA),
            )),
        loadingBalance,
      ],
    );
  }
}
