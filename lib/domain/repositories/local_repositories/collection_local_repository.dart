import 'package:flash_cards/data/local_data/collection_local_data.dart';
import 'package:flash_cards/data/model/collection_model.dart';
import 'package:flash_cards/services/interfaces/collection_local_action_interface.dart';

class CollectionLocalRepository implements CollectionLocalAction {
  final CollectionLocalData collectionLocalData;

  CollectionLocalRepository(this.collectionLocalData);

  @override
  Future<void> createCollection(String name) async => await collectionLocalData.createCollection(name);

  @override
  Future<List<Collection>?> getListCollections() async => await collectionLocalData.getListCollections();

  @override
  Future<bool?> collectionNameAlreadyExists(String collectionName) async =>
    await collectionLocalData.collectionNameAlreadyExists(collectionName);

  @override
  Future<bool> deleteCollectionByName(String collectionName) async =>
    await collectionLocalData.deleteCollectionByName(collectionName);

  @override
  Future<Collection> getCollectionByName(String collectionName) async =>
    await collectionLocalData.getCollectionByName(collectionName);

  @override
  Future<void> setCollection(String collectionName, Collection collectionModel) async =>
    await collectionLocalData.setCollection(collectionName, collectionModel);
}