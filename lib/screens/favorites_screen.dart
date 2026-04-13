import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/models/quote.dart';
import '../providers/quote_feed_provider.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final TextStyle urduStyle = GoogleFonts.getFont(
      'Noto Nastaliq Urdu',
      fontSize: 21,
      height: 1.86,
      fontWeight: FontWeight.w500,
      color: scheme.primary,
    );
    final QuoteFeedState state = ref.watch(quoteFeedProvider);
    final List<Quote> favorites = state.favoriteQuotes;

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favorites.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(Icons.favorite_border_rounded, size: 56),
                    const SizedBox(height: 12),
                    Text(
                      'No favorites yet',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Tap the heart icon on any quote to save it here.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (BuildContext context, int index) {
                final Quote quote = favorites[index];

                return Card(
                  margin: const EdgeInsets.fromLTRB(14, 9, 14, 9),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color:
                                scheme.primaryContainer.withValues(alpha: 0.75),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            quote.category,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          quote.textEn,
                          style: theme.textTheme.titleMedium
                              ?.copyWith(height: 1.4),
                        ),
                        const SizedBox(height: 10),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              quote.textUr,
                              textAlign: TextAlign.right,
                              style: urduStyle,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color:
                                scheme.primaryContainer.withValues(alpha: 0.55),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text('❤️', style: TextStyle(fontSize: 14)),
                              const SizedBox(width: 6),
                              Text(
                                'Saved',
                                style: theme.textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
