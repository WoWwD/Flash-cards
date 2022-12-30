import 'dart:convert';
import 'package:flash_cards/data/model/dictionary_model.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/repositories/local_repositories/dictionary_local_repository.dart';

class DictionaryProviderModel extends ChangeNotifier {
  final DictionaryLocalRepository dictionaryLocalRepository;
  
  DictionaryProviderModel({required this.dictionaryLocalRepository});

  List<Dictionary> _listDictionaries = [];
  bool _isLoading = true;

  List<Dictionary> get listDictionaries => _listDictionaries;
  bool get isLoading => _isLoading;

  Future<void> createDictionary(String name) async => await dictionaryLocalRepository.createDictionary(name);

  Future<void> getListDictionaries() async {
    _listDictionaries = await dictionaryLocalRepository.getListDictionaries() ?? [];
    _isLoading = false;
    notifyListeners();
  }

  Future<bool?> dictionaryNameAlreadyExists(String dictionaryName) async =>
    await dictionaryLocalRepository.dictionaryNameAlreadyExists(dictionaryName);

  Future<bool> deleteDictionaryByName(String dictionaryName) async =>
    await dictionaryLocalRepository.deleteDictionaryByName(dictionaryName);

  Future<String> dictionaryToJson(String dictionaryName) async {
    final Dictionary dictionaryModel = await dictionaryLocalRepository.getDictionaryByName(dictionaryName);
    return jsonEncode(dictionaryModel.toJson());
  }

  Future<bool> createDictionaryFromJson(String name, String dictionaryJson) async {
    try {
      final Dictionary dictionaryModel = Dictionary.fromJson(json.decode(dictionaryJson));
      await dictionaryLocalRepository.createDictionary(name);
      await dictionaryLocalRepository.setDictionary(
        name,
        Dictionary(name: name, listCards: dictionaryModel.listCards)
      );
      return true;
    }
    on FormatException {
      return false;
    }
  }
}