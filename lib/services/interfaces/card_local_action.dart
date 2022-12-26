import '../../data/model/flash_card_model.dart';

abstract class CardLocalAction {
  Future<void> createCard(String nameCollection, FlashCard cardModel);
  Future<List<FlashCard>> getListCards(String nameCollection);
  Future<bool> cardAlreadyExists(String nameCollection, FlashCard cardModel);
  Future<void> deleteCardByIndex(String nameCollection, int index);
}