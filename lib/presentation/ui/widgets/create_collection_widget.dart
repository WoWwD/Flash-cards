import 'package:flash_cards/presentation/ui/widgets/primary_alert_dialog_widget.dart';
import 'package:flash_cards/presentation/ui/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/constants/app_constants.dart';
import '../../../services/errors/input_errors.dart';
import '../../../services/validators/text_field_validator.dart';
import '../../provider/collection_provider_model.dart';

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
          validator: (value) => TextFieldValidator.get(value ?? ''),
          maxLength: AppConstants.textMaxLength,
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

  void _createCollection(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await context.read<CollectionProviderModel>().collectionNameAlreadyExists(_textEditingController.text)
        .then((value) async {
          if (value == null || !value) {
            await context.read<CollectionProviderModel>().createCollection(_textEditingController.text)
              .then((value) => Navigator.pop(context));
          }
          else {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text(InputErrors.collectionAlreadyExists)));
          }
          return null;
        }
      );
    }
  }
}