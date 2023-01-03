import 'dart:convert';
import 'package:flash_cards/data/model/dictionary_model.dart';
import 'package:flash_cards/services/interfaces/card_local_action.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/flash_card_model.dart';

class CardLocalData implements CardLocalAction {
  @override
  Future<void> createCard(String nameCollection, FlashCard cardModel) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Dictionary collectionModel = Dictionary.fromJson(json.decode(sp.getString(nameCollection)!));
    collectionModel.listCards.add(cardModel);
    collectionModel.listCards.sort((a, b) => a.word.compareTo(b.word));
    await sp.setString(nameCollection, json.encode(collectionModel.toJson()));
  }

  @override
  Future<List<FlashCard>> getListCards(String nameCollection) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? collectionJson = sp.getString(nameCollection);
    return Dictionary.fromJson(json.decode(collectionJson!)).listCards;
  }

  @override
  Future<void> deleteCardByIndex(String nameCollection, int index) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Dictionary collectionModel = Dictionary.fromJson(json.decode(sp.getString(nameCollection)!));
    collectionModel.listCards.removeAt(index);
    sp.setString(nameCollection, json.encode(collectionModel.toJson()));
  }

  @override
  Future<bool> cardAlreadyExists(String nameCollection, String word) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Dictionary collectionModel = Dictionary.fromJson(json.decode(sp.getString(nameCollection)!));
    return collectionModel.listCards.indexWhere((element) => element.word == word) != -1;
  }
}