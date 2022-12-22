import 'package:flash_cards/presentation/provider/settings_model.dart';
import 'package:flash_cards/presentation/ui/widgets/nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<SettingsModel>(context);

    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: themeMode.darkMode ? ThemeMode.dark : ThemeMode.light,
      home: const NavBarWidget(),
    );
  }
}