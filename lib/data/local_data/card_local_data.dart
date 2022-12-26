import 'dart:convert';
import 'package:flash_cards/data/model/collection_model.dart';
import 'package:flash_cards/services/interfaces/card_local_action.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/flash_card_model.dart';

class CardLocalData implements CardLocalAction {

  @override
  Future<bool> cardAlreadyExists(String nameCollection, FlashCard cardModel) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Collection collectionModel = Collection.fromJson(json.decode(sp.getString(nameCollection)!));
    return collectionModel.listCards.contains(cardModel);
  }

  @override
  Future<void> createCard(String nameCollection, FlashCard cardModel) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Collection oldCollectionModel = Collection.fromJson(json.decode(sp.getString(nameCollection)!));
    final Collection newCollectionModel = Collection(
      name: oldCollectionModel.name,
      listCards: oldCollectionModel.listCards
    );
    newCollectionModel.listCards.add(cardModel);
    await sp.setString(nameCollection, json.encode(newCollectionModel.toJson()));
  }

  @override
  Future<List<FlashCard>> getListCards(String nameCollection) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? collectionJson = sp.getString(nameCollection);
    return Collection.fromJson(json.decode(collectionJson!)).listCards;
  }

  @override
  Future<void> deleteCardByIndex(String nameCollection, int index) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Collection collectionModel = Collection.fromJson(json.decode(sp.getString(nameCollection)!));
    collectionModel.listCards.removeAt(index);
    sp.setString(nameCollection, json.encode(collectionModel.toJson()));
  }
}