import 'dart:convert';
import 'package:flash_cards/data/model/collection_model.dart';
import 'package:flash_cards/services/interfaces/collection_local_action_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/constants/app_constants.dart';

class CollectionLocalData implements CollectionLocalAction {
  final String _listCollectionsStorage = AppConstants.listCollectionsStorage;

  @override
  Future<void> createCollection(String name) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Collection newCollectionModel = Collection(name: name, listCards: []);
    final List<String> listKeys = sp.getStringList(_listCollectionsStorage) ?? [];
    listKeys.add(name);
    await sp.setString(name, json.encode(newCollectionModel.toJson()));
    await sp.setStringList(_listCollectionsStorage, listKeys);
  }

  @override
  Future<List<Collection>?> getListCollections() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final List<Collection> listCollections = [];
    final List<String>? listKeys = sp.getStringList(_listCollectionsStorage);
    if (listKeys != null) {
      for (int i = 0; i < listKeys.length; i++) {
        String? collectionJson = sp.getString(listKeys[i]);
        if (collectionJson != null) {
          listCollections.add(Collection.fromJson(json.decode(collectionJson)));
        }
      }
      return listCollections;
    }
    return null;
  }

  @override
  Future<bool?> collectionNameAlreadyExists(String collectionName) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final List<String>? listKeys = sp.getStringList(_listCollectionsStorage);
    if (listKeys != null) {
      return listKeys.contains(collectionName);
    }
    return null;
  }

  @override
  Future<bool> deleteCollectionByName(String collectionName) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final List<String>? listKeys = sp.getStringList(_listCollectionsStorage);
    if (listKeys != null && listKeys.contains(collectionName)) {
      listKeys.remove(collectionName);
      await sp.remove(collectionName);
      await sp.setStringList(_listCollectionsStorage, listKeys);
      return true;
    }
    else {
      return false;
    }
  }

  @override
  Future<Collection> getCollectionByName(String collectionName) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String collectionJson = sp.getString(collectionName)!;
    return Collection.fromJson(json.decode(collectionJson));
  }

  @override
  Future<void> setCollection(String collectionName, Collection collectionModel) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(collectionName, json.encode(collectionModel.toJson()));
  }
}