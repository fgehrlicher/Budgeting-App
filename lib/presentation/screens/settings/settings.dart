import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:unnamed_budgeting_app/presentation/screens/settings/settings_toggle.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: <Widget>[
          SettingsToggle(
            title: 'Dark Theme',
            onChanged: (_) => changeBrightness(),
            value: Theme.of(context).brightness == Brightness.dark,
          ),
        ],
      ),
    );
  }
}
