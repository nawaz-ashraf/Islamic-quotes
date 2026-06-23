import 'dart:isolate';

import 'package:flutter/services.dart';

import '../models/quote.dart';

class QuoteRepository {
  QuoteRepository(this._bundle);

  final AssetBundle _bundle;

  /// Loads all quotes from the curated JSON asset.
  ///
  /// Parsing runs in a background isolate so the first frame is never blocked.
  /// A deduplication pass ensures no two quotes share the same English text.
  Future<List<Quote>> loadQuotes() async {
    final String rawJson = await _bundle.loadString('assets/quotes.json');
    return Isolate.run<List<Quote>>(() {
      final List<Quote> parsed = Quote.listFromJson(rawJson);

      // Deduplicate by normalised English text – keeps the first occurrence.
      final Map<String, Quote> unique = <String, Quote>{};
      for (final Quote q in parsed) {
        final String key = q.textEn.toLowerCase().trim();
        unique.putIfAbsent(key, () => q);
      }

      return unique.values.toList(growable: false);
    });
  }
}
