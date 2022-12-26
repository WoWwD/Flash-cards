import 'package:flash_cards/data/model/collection_model.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/repositories/local_repositories/collection_local_repository.dart';

class CollectionProviderModel extends ChangeNotifier {
  final CollectionLocalRepository collectionLocalRepository;
  
  CollectionProviderModel({required this.collectionLocalRepository});

  List<Collection> _listCollections = [];
  List<Collection> get listCollections => _listCollections;

  Future<void> createCollection(String name) async => await collectionLocalRepository.createCollection(name);

  Future<void> getListCollections() async {
    _listCollections = await collectionLocalRepository.getListCollections() ?? [];
    notifyListeners();
  }

  Future<bool?> collectionNameAlreadyExists(String collectionName) async =>
    await collectionLocalRepository.collectionNameAlreadyExists(collectionName);

  Future<bool> deleteCollectionByName(String collectionName) async =>
    await collectionLocalRepository.deleteCollectionByName(collectionName);
}