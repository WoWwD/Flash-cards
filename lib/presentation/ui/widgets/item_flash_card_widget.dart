import 'package:flash_cards/services/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../data/model/flash_card_model.dart';

class ItemFlashCard extends StatelessWidget {
  final FlashCard flashCardModel;
  final Function(BuildContext)? onPressedDelete;
  final Function(BuildContext)? onPressedMove;

  const ItemFlashCard({
    Key? key,
    required this.flashCardModel,
    this.onPressedDelete,
    this.onPressedMove
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.6,
        dragDismissible: false,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp),
            onPressed: onPressedMove,
            backgroundColor: Colors.blueAccent,
            icon: Icons.arrow_forward_rounded,
            label: 'Переместить',
          ),
          SlidableAction(
            borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp),
            onPressed: onPressedDelete,
            backgroundColor: Colors.redAccent,
            icon: Icons.delete,
            label: 'Удалить',
          ),
        ],
      ),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 70,
          child: Row(
            children: [
              Expanded(child: Center(child: Text(flashCardModel.word, style: const TextStyle(fontSize: 18)))),
              const VerticalDivider(indent: 10, endIndent: 10),
              Expanded(child: Center(child: Text(flashCardModel.translate, style: const TextStyle(fontSize: 18)))),
            ],
          ),
        )
      ),
    );
  }
}