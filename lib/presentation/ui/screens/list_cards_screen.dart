import 'package:flash_cards/presentation/provider/card_provider_model.dart';
import 'package:flash_cards/presentation/ui/widgets/create_card_widget.dart';
import 'package:flash_cards/presentation/ui/widgets/primary_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/constants/app_styles.dart';
import '../widgets/item_flash_card_widget.dart';

class ListCardsScreen extends StatelessWidget {
  final String dictionaryName;

  const ListCardsScreen({
    Key? key,
    required this.dictionaryName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffoldWidget(
      titleText: dictionaryName,
      child: Consumer<CardProviderModel>(
        builder: (context, model, child) {
          model.getListCards(dictionaryName);
          if (model.listCards.isEmpty) return _create(context);

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 24),
            itemBuilder: (context, index) {
              if (index == model.listCards.length - 1) {
                return Column(
                  children: [
                    ItemFlashCard(
                      flashCardModel: model.listCards[index],
                      onPressedDelete: (context) => model.deleteCard(dictionaryName, index),
                    ),
                    _create(context)
                  ],
                );
              }
              return ItemFlashCard(
                flashCardModel: model.listCards[index],
                onPressedDelete: (context) => model.deleteCard(dictionaryName, index),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 28),
            itemCount: model.listCards.length,
          );
        }
      )
    );
  }

  Widget _create(BuildContext context) => Container(
    alignment: Alignment.topCenter,
    padding: const EdgeInsets.only(top: 28),
    child: Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 96),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp)),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp),
        onTap: () => showDialog(
          context: context,
          builder: (context) => CreateCard(dictionaryName: dictionaryName)
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add),
              SizedBox(width: 16),
              Text('Создать карточку')
            ],
          ),
        ),
      )
    ),
  );
}