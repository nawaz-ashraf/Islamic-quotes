import 'dart:convert';

class Quote {
  const Quote({
    required this.id,
    required this.textEn,
    required this.textUr,
    required this.source,
    required this.category,
  });

  final int id;
  final String textEn;
  final String textUr;
  final String source;
  final String category;

  // Backward-compatible alias for legacy call-sites.
  String get text => textEn;

  String get bilingualText => textUr == textEn ? textEn : '$textEn\n$textUr';

  String get shareBody => '$bilingualText\n— $source';

  factory Quote.fromMap(Map<String, dynamic> map) {
    final String parsedTextEn =
        (map['text_en'] ?? map['text'] ?? '').toString().trim();
    final String parsedTextUr =
        (map['text_ur'] ?? map['text_urdu'] ?? parsedTextEn).toString().trim();

    return Quote(
      id: (map['id'] as num).toInt(),
      textEn: parsedTextEn,
      textUr: parsedTextUr,
      source: map['source'] as String,
      category: map['category'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text_en': textEn,
      'text_ur': textUr,
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
