import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../core/services/ad_service.dart';
import '../data/models/quote.dart';
import '../providers/quote_feed_provider.dart';
import '../widgets/quote_actions_sheet.dart';
import '../widgets/quote_card.dart';
import '../widgets/quote_detail_overlay.dart';

class HomeFeedScreen extends ConsumerStatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  ConsumerState<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends ConsumerState<HomeFeedScreen> {
  PageController? _pageController;
  int _lastIndex = 0;

  static const double _topOverlayReservedSpace = 56;

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  void _ensurePageControllerInitialized(
      QuoteFeedState state, List<Quote> quotes) {
    if (_pageController != null || quotes.isEmpty) {
      return;
    }

    final int startupIndex = state.initialFeedIndex.clamp(0, quotes.length - 1);
    _lastIndex = startupIndex;
    _pageController = PageController(initialPage: startupIndex);
  }

  Future<void> _copyQuote(Quote quote) async {
    await Clipboard.setData(ClipboardData(text: quote.shareBody));
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Quote copied to clipboard.')),
    );
  }

  Future<void> _shareQuote(Quote quote) {
    return Share.share(quote.shareBody);
  }

  Future<void> _openDetail(Quote quote, bool isFavorite) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
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

  Future<void> _openActions(Quote quote, bool isFavorite) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (_) => QuoteActionsSheet(
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
    final List<Quote> quotes = state.feedQuotes;

    if (state.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (quotes.isEmpty) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(Icons.menu_book_rounded, size: 56),
                const SizedBox(height: 14),
                Text(
                  'No quotes found for this category.',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Try another category or return to all quotes.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                FilledButton.tonal(
                  onPressed: () => notifier.setFeedCategory(null),
                  child: const Text('Show all quotes'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    _ensurePageControllerInitialized(state, quotes);

    final PageController pageController = _pageController!;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: _topOverlayReservedSpace),
            child: PageView.builder(
              controller: pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: (int index) {
                _lastIndex = index;
                // Gentle tactile feedback mimics premium reels-like UX.
                HapticFeedback.selectionClick();
                // Pagination preloading: extend the list as user approaches the end.
                notifier.maybeLoadMore(index);
                AdService.registerInteraction();
              },
              itemCount: quotes.length,
              itemBuilder: (BuildContext context, int index) {
                final Quote quote = quotes[index];
                final bool isFavorite = notifier.isFavorite(quote.id);

                final Widget card = QuoteCard(
                  quote: quote,
                  isFavorite: isFavorite,
                  onFavorite: () => notifier.toggleFavorite(quote.id),
                  onTap: () => _openDetail(quote, isFavorite),
                  onLongPress: () => _openActions(quote, isFavorite),
                );

                // Motion polish: subtle scale/opacity based on scroll position.
                return AnimatedBuilder(
                  animation: pageController,
                  child: card,
                  builder: (BuildContext context, Widget? child) {
                    double page = _lastIndex.toDouble();
                    if (pageController.hasClients &&
                        pageController.position.hasContentDimensions) {
                      page = pageController.page ?? _lastIndex.toDouble();
                    }

                    final double delta = (page - index).clamp(-1.0, 1.0);
                    final double t = delta.abs();

                    final double scale = lerpDouble(1.0, 0.965, t)!;
                    final double opacity = lerpDouble(1.0, 0.60, t)!;
                    final double translateY =
                        lerpDouble(0.0, 18.0, t)! * (delta.isNegative ? -1 : 1);

                    return Transform.translate(
                      offset: Offset(0, translateY),
                      child: Transform.scale(
                        scale: scale,
                        alignment: Alignment.center,
                        child: Opacity(opacity: opacity, child: child),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: scheme.surface.withValues(alpha: 0.96),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color:
                                scheme.outlineVariant.withValues(alpha: 0.45),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.auto_awesome_rounded, size: 17),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                state.selectedFeedCategory != null
                                    ? 'Category: ${state.selectedFeedCategory}'
                                    : 'Daily Inspiration Feed',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
