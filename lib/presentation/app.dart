import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:unnamed_budgeting_app/presentation/frame.dart';

class UnnamedBudgetingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.dark,
      data: (brightness) => ThemeData(brightness: brightness),
      themedWidgetBuilder: (context, theme) => MaterialApp(
        home: Frame(),
        theme: theme,
      ),
    );
  }
}
