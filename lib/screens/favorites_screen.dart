import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../data/models/quote.dart';
import '../providers/quote_feed_provider.dart';
import '../widgets/quote_detail_overlay.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  Future<void> _copyQuote(Quote quote) async {
    await Clipboard.setData(
        ClipboardData(text: '${quote.text}\n— ${quote.source}'));
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Quote copied to clipboard.')),
    );
  }

  Future<void> _shareQuote(Quote quote) {
    return Share.share('${quote.text}\n— ${quote.source}');
  }

  void _openDetail(Quote quote, bool isFavorite) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => QuoteDetailOverlay(
        quote: quote,
        isFavorite: isFavorite,
        onFavorite: () =>
            ref.read(quoteFeedProvider.notifier).toggleFavorite(quote.id),
        onCopy: () => _copyQuote(quote),
        onShare: () => _shareQuote(quote),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final QuoteFeedState state = ref.watch(quoteFeedProvider);
    final QuoteFeedNotifier notifier = ref.read(quoteFeedProvider.notifier);
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
                  margin: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(26),
                    onTap: () => _openDetail(quote, true),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: scheme.primaryContainer
                                  .withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              quote.category,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            quote.text,
                            style: theme.textTheme.titleMedium
                                ?.copyWith(height: 1.4),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            quote.source,
                            style: theme.textTheme.bodySmall,
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: <Widget>[
                              OutlinedButton.icon(
                                onPressed: () => _copyQuote(quote),
                                icon: const Icon(Icons.copy_rounded),
                                label: const Text('Copy'),
                              ),
                              OutlinedButton.icon(
                                onPressed: () => _shareQuote(quote),
                                icon: const Icon(Icons.share_rounded),
                                label: const Text('Share'),
                              ),
                              FilledButton.tonalIcon(
                                onPressed: () =>
                                    notifier.toggleFavorite(quote.id),
                                icon: const Icon(Icons.favorite_rounded),
                                label: const Text('Saved'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
