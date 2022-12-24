import 'package:flutter/cupertino.dart';
import '../../domain/repositories/local_repositories/collection_local_repository.dart';

class CollectionCardsModel extends ChangeNotifier {
  final CollectionLocalRepository collectionLocalRepository;
  
  CollectionCardsModel({required this.collectionLocalRepository});
  
  Future<void> createCollection(String name) async => await collectionLocalRepository.createCollection(name);
  Future<void> getListCollections() async => await collectionLocalRepository.getListCollections();
}