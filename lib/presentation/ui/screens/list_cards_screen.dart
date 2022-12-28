import 'package:flash_cards/presentation/provider/card_provider_model.dart';
import 'package:flash_cards/presentation/ui/widgets/create_card_widget.dart';
import 'package:flash_cards/presentation/ui/widgets/primary_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/item_flash_card_widget.dart';

class ListCardsScreen extends StatelessWidget {
  final String nameCollection;

  const ListCardsScreen({
    Key? key,
    required this.nameCollection
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffoldWidget(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => CreateCard(nameCollection: nameCollection)
        )
      ),
      titleText: nameCollection,
      child: Consumer<CardProviderModel>(
        builder: (context, model, child) {
          model.getListCards(nameCollection);
          if (model.listCards.isEmpty) return _firstCard();

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 24),
            itemBuilder: (context, index) => ItemFlashCard(
              flashCardModel: model.listCards[index],
              onPressedDelete: (context) => model.deleteCard(nameCollection, index),
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