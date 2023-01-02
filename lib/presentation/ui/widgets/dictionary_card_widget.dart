import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DictionaryCard extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  final Function(BuildContext)? onPressedUpload;
  final Function(BuildContext)? onPressedDelete;
  final VoidCallback? startLearning;
  final int amountCards;

  const DictionaryCard({
    Key? key,
    required this.name,
    required this.onTap,
    this.onPressedUpload,
    this.onPressedDelete,
    this.startLearning,
    required this.amountCards
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        dragDismissible: false,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: onPressedUpload,
            backgroundColor: Colors.blueAccent,
            icon: Icons.upload,
            label: 'Импорт',
          ),
          SlidableAction(
            onPressed: onPressedDelete,
            backgroundColor: Colors.redAccent,
            icon: Icons.delete,
            label: 'Удалить',
          ),
        ],
      ),
      child: ListTile(
        subtitle: Text('Карточек: $amountCards'),
        title: Text(name),
        onTap: onTap,
        trailing: IconButton(
          splashRadius: 30,
          onPressed: startLearning,
          icon: const Icon(Icons.school, color: Colors.green),
        ),
      ),
    );
  }
}
