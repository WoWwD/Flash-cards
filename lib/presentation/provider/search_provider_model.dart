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
  bool _isLoading = true;

  bool get isLoading => _isLoading;
  List<FlashCard> get foundFlashcards => _foundFlashcards;

  Future<void> search(String searchedValue) async {
    List<Collection> listCollections = [];
    List<FlashCard> listFlashCards = [];
    listCollections = await collectionLocalRepository.getListCollections() ?? [];
    for (int i = 0; i < listCollections.length; i++) {
      listFlashCards.addAll(listCollections[i].listCards
        .where((element) => element.translate.contains(searchedValue) || element.word.contains(searchedValue))
      );
    }
    _foundFlashcards = listFlashCards;
    _isLoading = false;
    notifyListeners();
  }
}