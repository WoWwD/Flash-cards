import 'package:flash_cards/data/model/flash_card_model.dart';
import 'package:flash_cards/presentation/provider/card_provider_model.dart';
import 'package:flash_cards/presentation/ui/widgets/primary_alert_dialog_widget.dart';
import 'package:flash_cards/presentation/ui/widgets/primary_button_widget.dart';
import 'package:flash_cards/services/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/errors/input_errors.dart';

class CreateCard extends StatefulWidget {
  final String nameCollection;

  const CreateCard({Key? key, required this.nameCollection}) : super(key: key);

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
              validator: (value) => _validator(value ?? ''),
              maxLength: 24,
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
              validator: (value) => _validator(value ?? ''),
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
          PrimaryButton(
            size: const Size(100, 30),
            text: 'Создать',
            onPressed: () => _createCollection(context),
          )
        ]
      )
    );
  }

  String? _validator(String value) {
    if (value.toString().isEmpty) {
      return InputErrors.empty;
    }
    if (value.toString().isMaxLength()) {
      return InputErrors.maxLength;
    }
    return null;
  }

  void _createCollection(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final FlashCard flashCardModel = FlashCard(
        word: _wordController.text,
        translate: _translateController.text
      );
      final bool cardAlreadyExists =
        await context.read<CardProviderModel>().cardAlreadyExists(widget.nameCollection, flashCardModel);
      if (!cardAlreadyExists) {
        if (!mounted) return;
        await context.read<CardProviderModel>().createCard(widget.nameCollection, flashCardModel);
        if (!mounted) return;
        Navigator.pop(context);
      }
    }
  }
}