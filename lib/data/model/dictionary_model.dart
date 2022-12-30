import 'flash_card_model.dart';

class Dictionary {
  final String name;
  final List<FlashCard> listCards;

  Dictionary({required this.name, required this.listCards});

  factory Dictionary.fromJson(Map<String, dynamic> json) {
    final List<FlashCard> listCards = [];
    json['cards'].forEach((item) {
      listCards.add(FlashCard.fromJson(item));
    });

    return Dictionary(
      name: json['name'],
      listCards: listCards,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['cards'] = listCards.map((item) => item.toJson()).toList();
    return data;
  }
}