import 'package:flash_cards/presentation/provider/collection_cards_model.dart';
import 'package:flash_cards/presentation/ui/widgets/card_collection_widget.dart';
import 'package:flash_cards/presentation/ui/widgets/create_collection_widget.dart';
import 'package:flash_cards/presentation/ui/widgets/primary_alert_dialog_widget.dart';
import 'package:flash_cards/presentation/ui/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/primary_scaffold_widget.dart';

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffoldWidget(
      titleText: 'Коллекция карточек',
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const CreateCollection()
        ),
      ),
      child: Consumer<CollectionCardsModel>(
        builder: (context, model, child) {
          model.getListCollections();
          if (model.listCollections.isEmpty) return _firstCollection();

          return ListView.separated(
            itemBuilder: (context, index) => CardCollection(
              name: model.listCollections[index].name,
              onTap: () {},
              upload: () {},
              delete: () => showDialog(
                context: context,
                builder: (context) => _deleteCollection(
                  () => model.deleteCollectionByName(model.listCollections[index].name),
                  context
                ),
              )
            ),
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemCount: model.listCollections.length
          );
        }
      )
    );
  }

  Widget _firstCollection() => const Text('Создайте вашу первую коллекцию карточек');

  Widget _deleteCollection(VoidCallback delete, BuildContext context) {
    return PrimaryAlertDialog(
      textTitle: 'Удалить коллекцию?',
      actions: [
        PrimaryButton(
          text: 'Да',
          onPressed: () {
            delete();
            Navigator.pop(context);
          }
        ),
        const SizedBox(width: 16),
        PrimaryButton(
          text: 'Нет',
          onPressed: () => Navigator.pop(context)
        ),
      ]
    );
  }
}