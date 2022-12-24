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
}