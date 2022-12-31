import 'dart:math';
import 'package:flutter/cupertino.dart';
import '../../data/model/flash_card_model.dart';

class LearningProviderModel extends ChangeNotifier {
  final Random _rnd = Random();
  List<FlashCard> _listCards = [];
  late int _numberCard;

  int get numberCard => _numberCard;
  List<FlashCard> get listCards => _listCards;

  void getListCards(List<FlashCard> listCards) {
    _numberCard = 0;
    _listCards = _mixCards(listCards);
    notifyListeners();
  }

  void nextCard() {
    _numberCard += 1;
    notifyListeners();
  }

  List<FlashCard> _mixCards(List<FlashCard> listCards) {
    for (int i = listCards.length - 1; i >= 1; i--)
    {
      int j = _rnd.nextInt(i + 1);
      var temp = listCards[j];
      listCards[j] = listCards[i];
      listCards[i] = temp;
    }
    return listCards;
  }
}