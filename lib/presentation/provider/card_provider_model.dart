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

  Future<bool> cardAlreadyExists(String nameCollection, FlashCard cardModel) async =>
    await cardLocalRepository.cardAlreadyExists(nameCollection, cardModel);

  Future<void> getListCards(String nameCollection) async {
    _listCards = await cardLocalRepository.getListCards(nameCollection);
    notifyListeners();
  }
}