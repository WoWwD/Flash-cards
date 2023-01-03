import 'package:flash_cards/domain/repositories/local_repositories/card_local_repository.dart';
import 'package:flutter/cupertino.dart';
import '../../data/model/flash_card_model.dart';

class CardProviderModel extends ChangeNotifier {
  final CardLocalRepository cardLocalRepository;

  CardProviderModel({required this.cardLocalRepository});

  List<FlashCard> _listCards = [];
  List<FlashCard> get listCards => _listCards;

  Future<void> createCard(String nameCollection, FlashCard cardModel) async =>
    await cardLocalRepository.createCard(nameCollection, cardModel);

  Future<void> deleteCard(String nameCollection, int index) async =>
    await cardLocalRepository.deleteCardByIndex(nameCollection, index);

  Future<void> getListCards(String nameCollection) async {
    _listCards = await cardLocalRepository.getListCards(nameCollection);
    _listCards.sort((a, b) => a.word.compareTo(b.word));
    notifyListeners();
  }

  Future<bool> cardAlreadyExists(String nameCollection, String word) async =>
    await cardLocalRepository.cardAlreadyExists(nameCollection, word);

  Future<bool> moveCardToDictionary(
    String oldCollection,
    String newCollection,
    FlashCard flashCardModel,
    int cardIndex
  ) async {
    if (!await cardLocalRepository.cardAlreadyExists(newCollection, flashCardModel.word)) {
      await cardLocalRepository.deleteCardByIndex(oldCollection, cardIndex);
      await cardLocalRepository.createCard(newCollection, flashCardModel);
      return true;
    }
    else {
      return false;
    }
  }
}