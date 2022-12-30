import 'package:flash_cards/presentation/provider/card_provider_model.dart';
import 'package:flash_cards/presentation/ui/widgets/create_card_widget.dart';
import 'package:flash_cards/presentation/ui/widgets/primary_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => CreateCard(dictionaryName: dictionaryName)
        )
      ),
      titleText: dictionaryName,
      child: Consumer<CardProviderModel>(
        builder: (context, model, child) {
          model.getListCards(dictionaryName);
          if (model.listCards.isEmpty) return _firstCard();

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 24),
            itemBuilder: (context, index) => ItemFlashCard(
              flashCardModel: model.listCards[index],
              onPressedDelete: (context) => model.deleteCard(dictionaryName, index),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 28),
            itemCount: model.listCards.length,
          );
        }
      )
    );
  }

  Widget _firstCard() => const Text('Создайте вашу первую карточку');
}