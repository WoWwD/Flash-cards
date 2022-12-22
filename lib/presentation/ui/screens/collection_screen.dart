import 'package:flutter/material.dart';
import '../widgets/primary_scaffold_widget.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffoldWidget(
      titleText: 'Коллекции слов',
      child: Container()
    );
  }
}