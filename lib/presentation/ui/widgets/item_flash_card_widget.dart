import 'package:flutter/material.dart';
import '../../../data/model/flash_card_model.dart';

class ItemFlashCard extends StatelessWidget {
  final FlashCard flashCardModel;
  final VoidCallback delete;

  const ItemFlashCard({
    Key? key,
    required this.flashCardModel,
    required this.delete
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(flashCardModel.word),
      subtitle: Text(flashCardModel.translate),
      trailing: IconButton(
        splashRadius: 30,
        onPressed: delete,
        icon: const Icon(Icons.delete, color: Colors.redAccent),
      )
    );
  }
}