import 'package:flash_cards/data/model/flash_card_model.dart';
import 'package:flash_cards/presentation/provider/card_provider_model.dart';
import 'package:flash_cards/presentation/ui/widgets/create_card_widget.dart';
import 'package:flash_cards/presentation/ui/widgets/primary_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/strings.dart';
import '../../provider/dictionary_provider_model.dart';
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
          builder: (context) => _SelectDictionary(
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

class _SelectDictionary extends StatelessWidget {
  final int cardIndex;
  final String oldCollectionName;
  final FlashCard flashCardModel;

  const _SelectDictionary({
    Key? key,
    required this.cardIndex,
    required this.oldCollectionName,
    required this.flashCardModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffoldWidget(
      titleText: 'Выберите словарь',
      child: Consumer<CardProviderModel>(
        builder: (contextCard, modelCard, childCard) {
          return Consumer<DictionaryProviderModel>(
            builder: (contextDictionary, modelDictionary, childDictionary) {
              modelDictionary.getListDictionaries();
              return ListView.separated(
                itemBuilder: (context, index) {
                  if (modelDictionary.listDictionaries[index].name == oldCollectionName) return const SizedBox();

                  return ListTile(
                    subtitle: Text('Карточек: ${modelDictionary.listDictionaries[index].listCards.length}'),
                    title: Text(modelDictionary.listDictionaries[index].name),
                    onTap: () => onTap(context, modelCard, cardIndex, modelDictionary.listDictionaries[index].name),
                  );
                },
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemCount: modelDictionary.listDictionaries.length
              );
            }
          );
        },
      )
    );
  }

  void onTap(
    BuildContext context,
    CardProviderModel model,
    int cardIndex,
    String newCollectionName,
    [bool mounted = true]
  ) async {
    bool result = await model.moveCardToDictionary(
      oldCollectionName,
      newCollectionName,
      flashCardModel,
      cardIndex
    );
    if (!mounted) return;
    if (result) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Карточка была перемещена')));
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(Strings.cardAlreadyExists)));
    }
  }
}