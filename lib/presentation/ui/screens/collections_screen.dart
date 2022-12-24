import 'package:flutter/material.dart';
import '../widgets/primary_scaffold_widget.dart';

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffoldWidget(
      titleText: 'Коллекции карточек',
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {  },
      ),
      child: ListView()
    );
  }
}