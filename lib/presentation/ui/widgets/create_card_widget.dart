import 'package:flash_cards/data/model/flash_card_model.dart';
import 'package:flash_cards/presentation/provider/card_provider_model.dart';
import 'package:flash_cards/presentation/ui/widgets/primary_alert_dialog_widget.dart';
import 'package:flash_cards/services/validators/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/constants/app_constants.dart';
import '../../../services/errors.dart';

class CreateCard extends StatefulWidget {
  final String dictionaryName;

  const CreateCard({Key? key, required this.dictionaryName}) : super(key: key);

  @override
  State<CreateCard> createState() => _CreateCardState();
}

class _CreateCardState extends State<CreateCard> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _translateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: PrimaryAlertDialog(
        height: 200,
        textTitle: 'Создание карточки',
        content: Column(
          children: [
            TextFormField(
              onChanged: (value) => setState(() {
                _wordController.text = value;
              }),
              validator: (value) => TextFieldValidator.get(value ?? ''),
              maxLength: AppConstants.textMaxLength,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Слово',
              ),
              //onChanged: onChanged
            ),
            const SizedBox(height: 16),
            TextFormField(
              onChanged: (value) => setState(() {
                _translateController.text = value;
              }),
              validator: (value) => TextFieldValidator.get(value ?? ''),
              maxLength: 24,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Перевод',
              ),
              //onChanged: onChanged
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => _create(context, widget.dictionaryName),
            child: const Text('Создать'),
          )
        ]
      )
    );
  }

  void _create(BuildContext context, String dictionaryName) async {
    if (_formKey.currentState!.validate()) {
      if (!await context.read<CardProviderModel>().cardAlreadyExists(dictionaryName, _wordController.text)) {
        final FlashCard flashCardModel = FlashCard(
          word: _wordController.text,
          translate: _translateController.text
        );
        await context.read<CardProviderModel>().createCard(widget.dictionaryName, flashCardModel)
          .then((value) => Navigator.pop(context));
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(Errors.cardAlreadyExists)));
      }
    }
  }
}