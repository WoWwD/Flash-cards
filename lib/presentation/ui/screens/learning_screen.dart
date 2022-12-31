import 'package:flash_cards/data/model/dictionary_model.dart';
import 'package:flash_cards/presentation/provider/learning_provider_model.dart';
import 'package:flash_cards/presentation/ui/widgets/primary_alert_dialog_widget.dart';
import 'package:flash_cards/presentation/ui/widgets/primary_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:flash_card/flash_card.dart';
import 'package:provider/provider.dart';
import 'package:flash_cards/services/di.dart' as di;

class LearningScreen extends StatelessWidget {
  final Dictionary dictionaryModel;

  const LearningScreen({
    Key? key,
    required this.dictionaryModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LearningProviderModel>(
      create: (_) => di.getIt()..getListCards(dictionaryModel.listCards),
      child: PrimaryScaffoldWidget(
        titleText: 'Обучение',
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: Consumer<LearningProviderModel>(
            builder: (context, model, child) {
              return Column(
                children: [
                  Expanded(
                    child: FlashCard(
                      duration: const Duration(milliseconds: 400),
                      height: 400,
                      width: 300,
                      frontWidget: _getWord(model.listCards[model.numberCard].word),
                      backWidget: _getWord(model.listCards[model.numberCard].translate)
                    ),
                  ),
                  IconButton(
                    splashRadius: 36,
                    iconSize: 46,
                    icon: const Icon(Icons.next_plan),
                    onPressed: () {
                      if (model.numberCard == model.listCards.length - 1) {
                        showDialog(
                          context: context,
                          builder: (context) => _cardsAreOver(context, model, dictionaryModel)
                        );
                      }
                      else {
                        model.nextCard();
                      }
                    },
                  )
                ],
              );
            },
          ),
        )
      ),
    );
  }

  Widget _getWord(String text) {
    return Center(
      child: Text(text, style: const TextStyle(fontSize: 22)),
    );
  }

  Widget _cardsAreOver(BuildContext context, LearningProviderModel model, Dictionary dictionaryModel) {
    return PrimaryAlertDialog(
      textTitle: 'Пройти заново?',
      actions: [
        TextButton(
          onPressed: () {
            model.getListCards(dictionaryModel.listCards);
            Navigator.pop(context);
          },
          child: const Text('Да')
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text('Нет')
        ),
      ]
    );
  }
}