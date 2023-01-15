import 'package:flash_cards/presentation/provider/search_provider_model.dart';
import 'package:flash_cards/presentation/ui/widgets/item_flash_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/model/flash_card_model.dart';
import '../../../services/constants/app_constants.dart';
import '../../../services/validators/text_field_validator.dart';
import '../widgets/primary_scaffold_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffoldWidget(
      titleText: 'Поиск',
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
        child: Column(
          children: [
            _textField(),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: Consumer<SearchProviderModel>(
                  builder: (context, model, child) {
                    if (model.foundFlashcards.isEmpty && !model.isLoading) return _nothingFound();
                    if (model.foundFlashcards.isEmpty && model.isLoading) return _findWord();
                    if (model.foundFlashcards.isNotEmpty) return _found(model.foundFlashcards);
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _nothingFound() => const Text('Ничего не найдено');

  Widget _findWord() => const Text('Найдите слово из ваших словарей');

  Widget _textField() {
    return Form(
      key: _formKey,
      child: TextFormField(
        onChanged: (value) => setState(() {
          _textEditingController.text = value;
        }),
        validator: (value) => TextFieldValidator.get(value ?? ''),
        maxLength: AppConstants.textMaxLength,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<SearchProviderModel>().search(_textEditingController.text);
              }
            },
            icon: const Icon(Icons.arrow_forward_ios),
            splashRadius: 30,
          )
        ),
      ),
    );
  }

  Widget _found(List<FlashCard> foundFlashCards) {
    return ListView.separated(
      controller: ScrollController(),
      padding: const EdgeInsets.symmetric(vertical: 16),
      separatorBuilder: (context, index) => const SizedBox(height: 28),
      itemCount: foundFlashCards.length,
      itemBuilder: (context, index) => 
        ItemFlashCard(flashCardModel: foundFlashCards[index], isSlidable: false)
    );
  }
}