import 'package:flash_cards/presentation/ui/widgets/primary_alert_dialog_widget.dart';
import 'package:flash_cards/presentation/ui/widgets/primary_button_widget.dart';
import 'package:flash_cards/services/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/errors/input_errors.dart';
import '../../provider/collection_cards_model.dart';

class CreateCollection extends StatefulWidget {
  const CreateCollection({Key? key}) : super(key: key);

  @override
  State<CreateCollection> createState() => _CreateCollectionState();
}

class _CreateCollectionState extends State<CreateCollection> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: PrimaryAlertDialog(
        textTitle: 'Создание коллекции',
        content: TextFormField(
          onChanged: (value) => setState(() {
            _textEditingController.text = value;
          }),
          validator: (value) => _validator(value ?? ''),
          maxLength: 24,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Название',
          ),
          //onChanged: onChanged
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
      final bool? portfolioAlreadyExists =
        await context.read<CollectionCardsModel>().collectionNameAlreadyExists(_textEditingController.text);
      if (portfolioAlreadyExists == null || !portfolioAlreadyExists) {
        if (!mounted) return;
        await context.read<CollectionCardsModel>().createCollection(_textEditingController.text);
        if (!mounted) return;
        Navigator.pop(context);
      }
    }
  }
}