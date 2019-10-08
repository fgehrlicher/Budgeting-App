import 'package:flutter/cupertino.dart';
import 'package:hunger_preventer/screens/settings/settings.dart';
import 'package:hunger_preventer/screens/transaction_list/transaction_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.settings),
          title: Text('Settings'),
        ),
      ]),
      tabBuilder: (context, index) {
        if (index == 0) {
          return TransactionList();
        } else if (index == 1) {
          return SettingsScreen();
        } else {
          return Text('test');
        }
      },
    );
  }
}
