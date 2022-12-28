import 'dart:convert';
import 'package:flash_cards/data/model/collection_model.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/repositories/local_repositories/collection_local_repository.dart';

class CollectionProviderModel extends ChangeNotifier {
  final CollectionLocalRepository collectionLocalRepository;
  
  CollectionProviderModel({required this.collectionLocalRepository});

  List<Collection> _listCollections = [];
  bool _isLoading = true;

  List<Collection> get listCollections => _listCollections;
  bool get isLoading => _isLoading;

  Future<void> createCollection(String name) async => await collectionLocalRepository.createCollection(name);

  Future<void> getListCollections() async {
    _listCollections = await collectionLocalRepository.getListCollections() ?? [];
    _isLoading = false;
    notifyListeners();
  }

  Future<bool?> collectionNameAlreadyExists(String collectionName) async =>
    await collectionLocalRepository.collectionNameAlreadyExists(collectionName);

  Future<bool> deleteCollectionByName(String collectionName) async =>
    await collectionLocalRepository.deleteCollectionByName(collectionName);

  Future<String> collectionToJson(String collectionName) async {
    final Collection collectionModel = await collectionLocalRepository.getCollectionByName(collectionName);
    return jsonEncode(collectionModel.toJson());
  }

  Future<bool> createCollectionFromJson(String name, String collectionJson) async {
    try {
      final Collection collectionModel = Collection.fromJson(json.decode(collectionJson));
      await collectionLocalRepository.createCollection(name);
      await collectionLocalRepository.setCollection(
        name,
        Collection(name: name, listCards: collectionModel.listCards)
      );
      return true;
    }
    on FormatException {
      return false;
    }
  }
}