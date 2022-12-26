import 'package:flutter/material.dart';

class CardCollection extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  final VoidCallback upload;
  final VoidCallback delete;
  final int amountCards;

  const CardCollection({
    Key? key,
    required this.name,
    required this.onTap,
    required this.upload,
    required this.delete,
    required this.amountCards
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: Text('Карточек: $amountCards'),
      title: Text(name),
      onTap: onTap,
      trailing: Wrap(
        spacing: 12,
        children: [
          IconButton(
            splashRadius: 30,
            onPressed: upload,
            icon: const Icon(Icons.upload),
          ),
          IconButton(
            splashRadius: 30,
            onPressed: delete,
            icon: const Icon(Icons.delete, color: Colors.redAccent),
          )
        ],
      ),
    );
  }
}
