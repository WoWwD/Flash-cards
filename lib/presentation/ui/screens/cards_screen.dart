import 'package:flutter/material.dart';
import '../widgets/primary_scaffold_widget.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffoldWidget(
      titleText: 'Карточки',
      child: Container()
    );
  }
}