import '../../data/model/collection_model.dart';

abstract class CollectionLocalAction {
  Future<void> createCollection(String name);
  Future<List<Collection>?> getListCollections();
}