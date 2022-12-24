import 'package:flash_cards/presentation/ui/widgets/theme_switcher_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/primary_scaffold_widget.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffoldWidget(
      titleText: 'Карточки',
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: ThemeSwitcher(),
        )
      ],
      child: Container()
    );
  }
}