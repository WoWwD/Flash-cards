import 'package:clipboard/clipboard.dart';
import 'package:flash_cards/data/model/dictionary_model.dart';
import 'package:flash_cards/presentation/provider/dictionary_provider_model.dart';
import 'package:flash_cards/presentation/ui/screens/learning_screen.dart';
import 'package:flash_cards/presentation/ui/screens/list_cards_screen.dart';
import 'package:flash_cards/presentation/ui/widgets/dictionary_card_widget.dart';
import 'package:flash_cards/presentation/ui/widgets/create_dictionary_widget.dart';
import 'package:flash_cards/presentation/ui/widgets/primary_alert_dialog_widget.dart';
import 'package:flash_cards/presentation/ui/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/strings.dart';
import '../widgets/primary_scaffold_widget.dart';
import '../widgets/theme_switcher_widget.dart';

class ListDictionariesScreen extends StatelessWidget {
  const ListDictionariesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffoldWidget(
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: ThemeSwitcher(),
        )
      ],
      titleText: 'Словарь',
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const CreateDictionary()
        ),
      ),
      child: Consumer<DictionaryProviderModel>(
        builder: (context, model, child) {
          model.getListDictionaries();
          if (model.listDictionaries.isEmpty && !model.isLoading) return _first();
          if (model.listDictionaries.isNotEmpty) {
            return ListView.separated(
              itemBuilder: (context, index) => DictionaryCard(
                amountCards: model.listDictionaries[index].listCards.length,
                name: model.listDictionaries[index].name,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListCardsScreen(dictionaryName: model.listDictionaries[index].name)
                  )
                ),
                onPressedUpload: (context) => _upload(model, model.listDictionaries[index].name, context),
                onPressedDelete: (context) => _delete(model, model.listDictionaries[index].name, context),
                startLearning: () => _startLearning(context, model.listDictionaries[index])
              ),
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemCount: model.listDictionaries.length
            );
          }

          return const CircularProgressIndicator();
        }
      )
    );
  }

  Widget _first() => const Text('Создайте ваш первый словарь');

  void _upload(DictionaryProviderModel model, String dictionaryName, BuildContext context) async {
    final String json = await model.dictionaryToJson(dictionaryName);
    FlutterClipboard.copy(json)
      .then((value) => ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('JSON скопирован в буфер обмена'))));
  }

  void _delete(DictionaryProviderModel model, String dictionaryName, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PrimaryAlertDialog(
        textTitle: 'Удалить словарь?',
        actions: [
          PrimaryButton(
            text: 'Да',
            onPressed: () => model.deleteDictionaryByName(dictionaryName)
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

  void _startLearning(BuildContext context, Dictionary dictionaryModel) {
    if (dictionaryModel.listCards.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LearningScreen(dictionaryModel: dictionaryModel)
        )
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(Strings.dictionaryIsEmpty))
      );
    }
  }
}