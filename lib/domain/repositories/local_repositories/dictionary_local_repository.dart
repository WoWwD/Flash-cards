import 'package:flash_cards/data/local_data/dictionary_local_data.dart';
import 'package:flash_cards/data/model/dictionary_model.dart';
import '../../../data/interface/dictionary_local_action_interface.dart';

class DictionaryLocalRepository implements DictionaryLocalAction {
  final DictionaryLocalData dictionaryLocalData;

  DictionaryLocalRepository(this.dictionaryLocalData);

  @override
  Future<void> createDictionary(String name) async => await dictionaryLocalData.createDictionary(name);

  @override
  Future<List<Dictionary>?> getListDictionaries() async => await dictionaryLocalData.getListDictionaries();

  @override
  Future<bool?> dictionaryNameAlreadyExists(String dictionaryName) async =>
    await dictionaryLocalData.dictionaryNameAlreadyExists(dictionaryName);

  @override
  Future<bool> deleteDictionaryByName(String dictionaryName) async =>
    await dictionaryLocalData.deleteDictionaryByName(dictionaryName);

  @override
  Future<Dictionary> getDictionaryByName(String dictionaryName) async =>
    await dictionaryLocalData.getDictionaryByName(dictionaryName);

  @override
  Future<void> setDictionary(String dictionaryName, Dictionary dictionaryModel) async =>
    await dictionaryLocalData.setDictionary(dictionaryName, dictionaryModel);
}