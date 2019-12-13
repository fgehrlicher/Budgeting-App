import 'dart:async';

import 'package:flutter/cupertino.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  static const int _maxDots = 3;
  int _dotCount;
  Timer _timer;

  @override
  void initState() {
    super.initState();

    _dotCount = 0;
    _timer = Timer.periodic(Duration(milliseconds: 150), (Timer t) => _tick());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _tick() {
    setState(() {
      _dotCount = _dotCount >= _maxDots ? 0 : _dotCount + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    var dots = "." * _dotCount;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Calculating " + dots,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xff0089BA)),
        ),
      ],
    );
  }
}
