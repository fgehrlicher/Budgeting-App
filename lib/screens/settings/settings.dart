import 'package:flutter/cupertino.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: ListView(
          children: [
            Text("123"),
            Text("345"),
            Text("678"),
            Text("91011"),
          ],
      ),
    );
  }
}