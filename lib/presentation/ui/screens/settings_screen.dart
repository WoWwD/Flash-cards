import 'package:flash_cards/presentation/ui/widgets/primary_scaffold_widget.dart';
import 'package:flutter/material.dart';
import '../../../services/constants/app_styles.dart';
import '../widgets/theme_switcher_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffoldWidget(
      titleText: 'Настройки',
      child: ListView(
        padding: AppStyles.mainPadding,
        children: const [
          ThemeSwitcher()
        ],
      ),
    );
  }
}