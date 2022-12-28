import 'package:flutter/cupertino.dart';
import '../../data/model/collection_model.dart';
import '../../data/model/flash_card_model.dart';
import '../../domain/repositories/local_repositories/card_local_repository.dart';
import '../../domain/repositories/local_repositories/collection_local_repository.dart';

class SearchProviderModel extends ChangeNotifier {
  final CardLocalRepository cardLocalRepository;
  final CollectionLocalRepository collectionLocalRepository;

  SearchProviderModel({
    required this.cardLocalRepository,
    required this.collectionLocalRepository
  });

  List<FlashCard> _foundFlashcards = [];
  List<FlashCard> get foundFlashcards => _foundFlashcards;

  Future<void> search() async {
    List<Collection> listCollections = [];
    listCollections = await collectionLocalRepository.getListCollections() ?? [];
    notifyListeners();
  }
}