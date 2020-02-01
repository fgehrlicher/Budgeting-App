import 'package:flutter/material.dart';

enum FetchIndicatorMode {
  Sleeping,
  Fetching,
  NoTransactionsLeft,
}

class FetchIndicator extends StatefulWidget {
  final _FetchIndicatorState _fetchIndicatorState = _FetchIndicatorState();

  void setSleeping() {
    _fetchIndicatorState.setMode(FetchIndicatorMode.Sleeping);
  }

  void setFetching() {
    _fetchIndicatorState.setMode(FetchIndicatorMode.Fetching);
  }

  void setNoTransactionsLeft() {
    _fetchIndicatorState.setMode(FetchIndicatorMode.NoTransactionsLeft);
  }

  bool isFetching() => _fetchIndicatorState.isFetching();

  @override
  _FetchIndicatorState createState() => _fetchIndicatorState;
}

class _FetchIndicatorState extends State<FetchIndicator> {
  FetchIndicatorMode _fetchIndicatorMode;

  bool isFetching() => _fetchIndicatorMode == FetchIndicatorMode.Fetching;

  void setMode(FetchIndicatorMode _mode) {
    if (!this.mounted) {
      return;
    }

    setState(() {
      _fetchIndicatorMode = _mode;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchIndicatorMode = FetchIndicatorMode.Sleeping;
  }

  @override
  Widget build(BuildContext context) {
    switch(_fetchIndicatorMode) {
      case FetchIndicatorMode.Sleeping: {
        return Container();
      }
      break;

      case FetchIndicatorMode.Fetching: {
        return CircularProgressIndicator();
      }
      break;

      case FetchIndicatorMode.NoTransactionsLeft: {
        return Text('no more transactions left');
      }
      break;

      default: {
        return Container();
      }
      break;
    }
  }
}
