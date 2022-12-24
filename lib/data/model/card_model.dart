class Card{
  final String word;
  final String translate;

  Card({required this.word, required this.translate});

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      word: json['word'],
      translate: json['translate'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['word'] = word;
    data['translate'] = translate;
    return data;
  }
}