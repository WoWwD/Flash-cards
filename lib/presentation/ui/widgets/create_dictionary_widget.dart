import 'package:clipboard/clipboard.dart';
import 'package:flash_cards/presentation/ui/widgets/primary_alert_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/constants/app_constants.dart';
import '../../../services/strings.dart';
import '../../../services/validators/text_field_validator.dart';
import '../../provider/dictionary_provider_model.dart';

class CreateDictionary extends StatefulWidget {
  const CreateDictionary({Key? key}) : super(key: key);

  @override
  State<CreateDictionary> createState() => _CreateDictionaryState();
}

class _CreateDictionaryState extends State<CreateDictionary> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  bool _isCreateFromJson = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: PrimaryAlertDialog(
        height: 150,
        textTitle: 'Создание словаря',
        content: Column(
          children: [
            TextFormField(
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
            const SizedBox(height: 8),
            CheckboxListTile(
              title: const Text('Импорт из буфера обмена', style: TextStyle(fontSize: 14)),
              value: _isCreateFromJson,
              onChanged: (bool? value) {
                setState(() {
                  _isCreateFromJson = value!;
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => _create(context),
            child: const Text('Создать')
          ),
        ]
      )
    );
  }

  void _create(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await context.read<DictionaryProviderModel>().dictionaryNameAlreadyExists(_textEditingController.text)
        .then((value) async {
          if (value == null || !value) {
            if (_isCreateFromJson) {
              await context.read<DictionaryProviderModel>()
                .createDictionaryFromJson(_textEditingController.text, await FlutterClipboard.paste())
                  .then((value) {
                  if (value) {
                    Navigator.pop(context);
                  }
                  else {
                    ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text(Strings.invalidFormatJson)));
                  }
                }
              );
            }
            else {
              await context.read<DictionaryProviderModel>().createDictionary(_textEditingController.text)
                .then((value) => Navigator.pop(context));
            }
          }
          else {
            ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text(Strings.dictionaryAlreadyExists)));
          }
          return null;
        }
      );
    }
  }
}