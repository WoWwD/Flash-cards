import 'dart:convert';
import 'package:flash_cards/data/interface/dictionary_local_action_interface.dart';
import 'package:flash_cards/data/model/dictionary_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/constants/app_constants.dart';

class DictionaryLocalData implements DictionaryLocalAction {
  final String _listDictionariesStorage = AppConstants.listDictionariesStorage;

  @override
  Future<void> createDictionary(String name) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Dictionary newDictionaryModel = Dictionary(name: name, listCards: []);
    final List<String> listKeys = sp.getStringList(_listDictionariesStorage) ?? [];
    listKeys.add(name);
    await sp.setString(name, json.encode(newDictionaryModel.toJson()));
    await sp.setStringList(_listDictionariesStorage, listKeys);
  }

  @override
  Future<List<Dictionary>?> getListDictionaries() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final List<Dictionary> listDictionaries = [];
    final List<String>? listKeys = sp.getStringList(_listDictionariesStorage);
    if (listKeys != null) {
      for (int i = 0; i < listKeys.length; i++) {
        String? dictionaryJson = sp.getString(listKeys[i]);
        if (dictionaryJson != null) {
          listDictionaries.add(Dictionary.fromJson(json.decode(dictionaryJson)));
        }
      }
      return listDictionaries;
    }
    return null;
  }

  @override
  Future<bool?> dictionaryNameAlreadyExists(String dictionaryName) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final List<String>? listKeys = sp.getStringList(_listDictionariesStorage);
    if (listKeys != null) {
      return listKeys.contains(dictionaryName);
    }
    return null;
  }

  @override
  Future<bool> deleteDictionaryByName(String dictionaryName) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final List<String>? listKeys = sp.getStringList(_listDictionariesStorage);
    if (listKeys != null && listKeys.contains(dictionaryName)) {
      listKeys.remove(dictionaryName);
      await sp.remove(dictionaryName);
      await sp.setStringList(_listDictionariesStorage, listKeys);
      return true;
    }
    else {
      return false;
    }
  }

  @override
  Future<Dictionary> getDictionaryByName(String dictionaryName) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String dictionaryJson = sp.getString(dictionaryName)!;
    return Dictionary.fromJson(json.decode(dictionaryJson));
  }

  @override
  Future<void> setDictionary(String dictionaryName, Dictionary dictionaryModel) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(dictionaryName, json.encode(dictionaryModel.toJson()));
  }
}