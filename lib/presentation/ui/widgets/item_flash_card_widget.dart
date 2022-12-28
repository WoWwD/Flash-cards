import 'package:flash_cards/services/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../data/model/flash_card_model.dart';

class ItemFlashCard extends StatelessWidget {
  final FlashCard flashCardModel;
  final Function(BuildContext)? onPressedDelete;

  const ItemFlashCard({
    Key? key,
    required this.flashCardModel,
    this.onPressedDelete
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: onPressedDelete != null
      ? ActionPane(
        extentRatio: 0.2,
        dragDismissible: false,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp),
            onPressed: onPressedDelete,
            backgroundColor: Colors.redAccent,
            icon: Icons.delete,
          ),
        ],
      )
      : null,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 70,
          child: Row(
            children: [
              Expanded(child: Center(child: Text(flashCardModel.word))),
              const VerticalDivider(indent: 10, endIndent: 10),
              Expanded(child: Center(child: Text(flashCardModel.translate))),
            ],
          ),
        )
      ),
    );
  }
}