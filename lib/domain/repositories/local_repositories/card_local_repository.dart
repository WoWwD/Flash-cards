import 'package:flash_cards/data/interface/card_local_action.dart';
import 'package:flash_cards/data/model/flash_card_model.dart';
import '../../../data/local_data/card_local_data.dart';

class CardLocalRepository implements CardLocalAction {
  final CardLocalData cardLocalData;

  CardLocalRepository(this.cardLocalData);

  @override
  Future<void> createCard(String nameCollection, FlashCard cardModel) async =>
    await cardLocalData.createCard(nameCollection, cardModel);

  @override
  Future<void> deleteCardByIndex(String nameCollection, int index) async =>
    await cardLocalData.deleteCardByIndex(nameCollection, index);

  @override
  Future<List<FlashCard>> getListCards(String nameCollection) async =>
    await cardLocalData.getListCards(nameCollection);

  @override
  Future<bool> cardAlreadyExists(String nameCollection, String word) async =>
    await cardLocalData.cardAlreadyExists(nameCollection, word);
}