import 'dart:math';
import 'package:flutter/cupertino.dart';
import '../../data/model/flash_card_model.dart';

class LearningProviderModel extends ChangeNotifier {
  final Random _rnd = Random();
  List<FlashCard> _listCards = [];
  int _numberCard = 0;


  int get numberCard => _numberCard;
  List<FlashCard> get listCards => _listCards;

  void getListCards(List<FlashCard> listCards) {
    _listCards = listCards;
    notifyListeners();
  }

  void nextCard() {
    _numberCard = _rnd.nextInt(_listCards.length);
    notifyListeners();
  }

  void learned() {
    _listCards.removeAt(_numberCard);
    notifyListeners();
  }
}