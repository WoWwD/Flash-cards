import 'card_model.dart';

class Collection {
  final String name;
  final List<Card> listCards;

  Collection({required this.name, required this.listCards});

  factory Collection.fromJson(Map<String, dynamic> json) {
    final List<Card> listCards = [];
    json['cards'].forEach((item) {
      listCards.add(Card.fromJson(item));
    });

    return Collection(
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