import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/app_constants.dart';
import '../core/constants/visual_section_data.dart';
import '../data/models/quote.dart';
import '../providers/quote_feed_provider.dart';
import '../widgets/category_card.dart';
import '../widgets/featured_quote_card.dart';
import '../widgets/section_header.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({required this.onApplyFilter, super.key});

  final ValueChanged<String?> onApplyFilter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final QuoteFeedState state = ref.watch(quoteFeedProvider);

    final Quote? featuredQuote =
        state.allQuotes.isNotEmpty ? state.allQuotes.first : null;

    final String featuredQuoteText =
        featuredQuote?.textEn ?? VisualSectionData.categoriesBanner.quote;
    final String featuredQuoteSource =
        featuredQuote?.source ?? VisualSectionData.categoriesBanner.source;

    final List<CategoryVisualData> visuals = AppConstants.categories
        .map(
          (String category) =>
              VisualSectionData.categoryByName[category] ??
              CategoryVisualData(
                category: category,
                title: category,
                icon: Icons.category_rounded,
                imageUrl: VisualSectionData.categoriesBanner.imageUrl,
              ),
        )
        .toList(growable: false);

    return Scaffold(
      body: Column(
        children: <Widget>[
          const SectionHeader(
            title: 'Categories',
            leadingIcon: Icons.menu_book_rounded,
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final int crossAxisCount = constraints.maxWidth >= 1024
                    ? 3
                    : (constraints.maxWidth >= 390 ? 2 : 1);

                final double gridSpacing = 12;
                final double tileHeight = crossAxisCount == 1 ? 170 : 196;
                final double tileWidth = (constraints.maxWidth -
                        32 -
                        (crossAxisCount - 1) * gridSpacing) /
                    crossAxisCount;

                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FeaturedQuoteCard(
                        quote: featuredQuoteText,
                        source: featuredQuoteSource,
                        imageUrl: VisualSectionData.categoriesBanner.imageUrl,
                        onTap: () {
                          onApplyFilter(null);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Showing all quotes in feed.'),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Browse by spiritual focus',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Tap a card to filter your home feed instantly.',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton.icon(
                        onPressed: () {
                          onApplyFilter(null);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Showing all quotes in feed.'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.grid_view_rounded),
                        label: const Text('All Quotes'),
                      ),
                      const SizedBox(height: 12),
                      GridView.builder(
                        itemCount: visuals.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: gridSpacing,
                          mainAxisSpacing: gridSpacing,
                          childAspectRatio: tileWidth / tileHeight,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final CategoryVisualData item = visuals[index];
                          final bool selected =
                              state.selectedFeedCategory == item.category;

                          return _CategoryTileWithMeta(
                            visual: item,
                            selected: selected,
                            onTap: () {
                              onApplyFilter(item.category);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Feed filtered by ${item.title}.',
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryTileWithMeta extends StatelessWidget {
  const _CategoryTileWithMeta({
    required this.visual,
    required this.selected,
    required this.onTap,
  });

  final CategoryVisualData visual;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: selected
            ? Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.95),
                width: 2,
              )
            : null,
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: CategoryCard(
              title: visual.title,
              icon: visual.icon,
              imageUrl: visual.imageUrl,
              onTap: onTap,
            ),
          ),
          if (selected)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
