import 'package:flash_cards/data/model/flash_card_model.dart';
import 'package:flash_cards/presentation/provider/card_provider_model.dart';
import 'package:flash_cards/presentation/ui/screens/move_to_dictionary.dart';
import 'package:flash_cards/presentation/ui/widgets/create_card_widget.dart';
import 'package:flash_cards/presentation/ui/widgets/primary_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/strings.dart';
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
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => CreateCard(dictionaryName: dictionaryName)
            ),
            icon: const Icon(Icons.add),
          ),
        )
      ],
      titleText: dictionaryName,
      child: Consumer<CardProviderModel>(
        builder: (context, model, child) {
          model.getListCards(dictionaryName);
          if (model.listCards.isEmpty) return _first();

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 24),
            itemBuilder: (context, index) {
              return ItemFlashCard(
                flashCardModel: model.listCards[index],
                onPressedDelete: (context) => model.deleteCard(dictionaryName, index),
                onPressedMove: (context) => _moveToDictionary(context, model, model.listCards[index], index),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 28),
            itemCount: model.listCards.length,
          );
        }
      )
    );
  }

  Widget _first() => const Center(child: Text('Добавьте первую карточку в словарь'));

  void _moveToDictionary(BuildContext context, CardProviderModel model, FlashCard flashCardModel, int cardIndex) {
    if (model.listCards.length != 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MoveToDictionary(
            cardIndex: cardIndex,
            oldCollectionName: dictionaryName,
            flashCardModel: flashCardModel
          )
        )
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(Strings.needOneMoreDictionary))
      );
    }
  }
}