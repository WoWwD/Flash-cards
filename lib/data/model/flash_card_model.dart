class FlashCard{
  final String word;
  final String translate;

  FlashCard({required this.word, required this.translate});

  factory FlashCard.fromJson(Map<String, dynamic> json) {
    return FlashCard(
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