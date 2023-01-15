import 'package:flash_cards/presentation/provider/card_provider_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/model/flash_card_model.dart';
import '../../../services/strings.dart';
import '../../provider/dictionary_provider_model.dart';
import '../widgets/primary_scaffold_widget.dart';

class MoveToDictionary extends StatelessWidget {
  final int cardIndex;
  final String oldCollectionName;
  final FlashCard flashCardModel;

  const MoveToDictionary({
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
                  if (modelDictionary.listDictionaries[index].name == oldCollectionName) {
                    return const SizedBox();
                  }

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