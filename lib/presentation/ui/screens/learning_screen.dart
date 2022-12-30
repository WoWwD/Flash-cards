import 'package:flash_cards/data/model/collection_model.dart';
import 'package:flash_cards/presentation/provider/learning_provider_model.dart';
import 'package:flash_cards/presentation/ui/widgets/primary_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:flash_card/flash_card.dart';
import 'package:provider/provider.dart';

class LearningScreen extends StatelessWidget {
  final Collection collectionModel;

  const LearningScreen({
    Key? key,
    required this.collectionModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffoldWidget(
      titleText: 'Обучение',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          children: [
            Expanded(
              child: Consumer<LearningProviderModel>(
                builder: (context, model, child) {
                  model.setListCards(collectionModel.listCards);
                  return FlashCard(
                    duration: const Duration(milliseconds: 400),
                    height: 400,
                    width: 300,
                    frontWidget: _getWord(model.listCards[model.numberCard].word),
                    backWidget: _getWord(model.listCards[model.numberCard].translate)
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 46,
                  icon: const Icon(Icons.done, color: Colors.green),
                  onPressed: () => context.read<LearningProviderModel>().learned(),
                ),
                const SizedBox(width: 50),
                IconButton(
                  iconSize: 46,
                  icon: const Icon(Icons.next_plan),
                  onPressed: () => context.read<LearningProviderModel>().nextCard(),
                )
              ],
            )
          ],
        ),
      )
    );
  }

  Widget _getWord(String text) {
    return Center(
      child: Text(text, style: const TextStyle(fontSize: 22)),
    );
  }
}
