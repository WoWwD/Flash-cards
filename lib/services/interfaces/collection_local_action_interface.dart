import '../../data/model/collection_model.dart';

abstract class CollectionLocalAction {
  Future<void> createCollection(String name);
  Future<List<Collection>?> getListCollections();
  /// Возвращает null если список коллекций пуст
  Future<bool?> collectionNameAlreadyExists(String collectionName);
  Future<bool> deleteCollectionByName(String collectionName);
}