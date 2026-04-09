import 'dart:convert';

class Quote {
  const Quote({
    required this.id,
    required this.text,
    required this.source,
    required this.category,
  });

  final int id;
  final String text;
  final String source;
  final String category;

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      id: map['id'] as int,
      text: map['text'] as String,
      source: map['source'] as String,
      category: map['category'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'source': source,
      'category': category,
    };
  }

  static List<Quote> listFromJson(String source) {
    final List<dynamic> decoded = jsonDecode(source) as List<dynamic>;

    return decoded
        .map((dynamic item) => Quote.fromMap(item as Map<String, dynamic>))
        .toList(growable: false);
  }
}
