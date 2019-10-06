import 'package:flutter/cupertino.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          title: Text('Home'),
        ),
      ]),
      tabBuilder: (context, index) {
        if (index == 0) {
          return Text("Home");
        } else {
          return Text('test');
        }
      },
    );
  }
}
