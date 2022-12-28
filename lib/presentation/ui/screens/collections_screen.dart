import 'package:clipboard/clipboard.dart';
import 'package:flash_cards/presentation/provider/collection_provider_model.dart';
import 'package:flash_cards/presentation/ui/screens/list_cards_screen.dart';
import 'package:flash_cards/presentation/ui/widgets/card_collection_widget.dart';
import 'package:flash_cards/presentation/ui/widgets/create_collection_widget.dart';
import 'package:flash_cards/presentation/ui/widgets/primary_alert_dialog_widget.dart';
import 'package:flash_cards/presentation/ui/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/primary_scaffold_widget.dart';
import '../widgets/theme_switcher_widget.dart';

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffoldWidget(
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: ThemeSwitcher(),
        )
      ],
      titleText: 'Коллекция карточек',
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const CreateCollection()
        ),
      ),
      child: Consumer<CollectionProviderModel>(
        builder: (context, model, child) {
          model.getListCollections();
          if (model.listCollections.isEmpty && !model.isLoading) return _firstCollection();
          if (model.listCollections.isNotEmpty) {
            return ListView.separated(
              itemBuilder: (context, index) => CardCollection(
                amountCards: model.listCollections[index].listCards.length,
                name: model.listCollections[index].name,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListCardsScreen(nameCollection: model.listCollections[index].name)
                  )
                ),
                onPressedUpload: (context) => _uploadCollection(model, model.listCollections[index].name, context),
                onPressedDelete: (context) => _deleteCollection(model, model.listCollections[index].name, context),
                startLearning: () {},
              ),
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemCount: model.listCollections.length
            );
          }

          return const CircularProgressIndicator();
        }
      )
    );
  }

  Widget _firstCollection() => const Text('Создайте вашу первую коллекцию карточек');

  void _uploadCollection(CollectionProviderModel model, String collectionName, BuildContext context) async {
    final String json = await model.collectionToJson(collectionName);
    FlutterClipboard.copy(json)
      .then((value) => ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('JSON скопирован в буфер обмена'))));
  }

  void _deleteCollection(CollectionProviderModel model, String collectionName, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PrimaryAlertDialog(
        textTitle: 'Удалить коллекцию?',
        actions: [
          PrimaryButton(
            text: 'Да',
            onPressed: () => model.deleteCollectionByName(collectionName)
              .then((value) => Navigator.pop(context))
          ),
          const SizedBox(width: 16),
          PrimaryButton(
            text: 'Нет',
            onPressed: () => Navigator.pop(context)
          ),
        ]
      )
    );
  }
}