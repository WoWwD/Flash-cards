import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/settings_provider_model.dart';

class ThemeSwitcher extends StatelessWidget{
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProviderModel>(
      builder: (context, model, child) {
        return IconButton(
          onPressed: () async => await model.setDarkMode(!model.darkMode),
          icon: model.darkMode
            ? const Icon(Icons.light_mode_outlined)
            : const Icon(Icons.dark_mode_outlined),
        );
      },
    );
  }
}