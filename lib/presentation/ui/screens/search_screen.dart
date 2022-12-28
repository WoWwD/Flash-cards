import 'package:flutter/material.dart';
import '../widgets/primary_scaffold_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffoldWidget(
      titleText: 'Поиск',
      child: Container()
    );
  }
}