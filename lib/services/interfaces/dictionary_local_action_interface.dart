import '../../data/model/dictionary_model.dart';

abstract class DictionaryLocalAction {
  Future<void> createDictionary(String name);
  Future<List<Dictionary>?> getListDictionaries();
  /// Возвращает null если список коллекций пуст
  Future<bool?> dictionaryNameAlreadyExists(String dictionaryName);
  Future<bool> deleteDictionaryByName(String dictionaryName);
  Future<Dictionary> getDictionaryByName(String dictionaryName);
  Future<void> setDictionary(String dictionaryName, Dictionary dictionaryModel);
}