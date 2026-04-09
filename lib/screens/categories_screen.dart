import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/app_constants.dart';
import '../data/models/quote.dart';
import '../providers/quote_feed_provider.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({required this.onApplyFilter, super.key});

  final ValueChanged<String?> onApplyFilter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final QuoteFeedState state = ref.watch(quoteFeedProvider);

    final Map<String, int> counts = <String, int>{
      for (final String category in AppConstants.categories)
        category: state.allQuotes
            .where((Quote quote) => quote.category == category)
            .length,
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final int crossAxisCount = constraints.maxWidth >= 900
              ? 3
              : (constraints.maxWidth >= 560 ? 2 : 1);

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: scheme.surfaceContainerLow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Browse by spiritual focus',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Select a category to filter your main feed instantly.',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: () {
                          onApplyFilter(null);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Showing all quotes in feed.')),
                          );
                        },
                        icon: const Icon(Icons.grid_view_rounded),
                        label: Text('All Quotes (${state.allQuotes.length})'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                GridView.builder(
                  itemCount: AppConstants.categories.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: crossAxisCount == 1 ? 2.4 : 1.25,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final String category = AppConstants.categories[index];
                    final bool selected =
                        state.selectedFeedCategory == category;

                    return InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        onApplyFilter(category);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Feed filtered by $category.')),
                        );
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: selected
                              ? scheme.primaryContainer
                              : scheme.surfaceContainerHigh
                                  .withValues(alpha: 0.45),
                          border: Border.all(
                            color: selected
                                ? scheme.primary.withValues(alpha: 0.5)
                                : scheme.outlineVariant.withValues(alpha: 0.35),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                category,
                                style: theme.textTheme.titleMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              Text(
                                '${counts[category] ?? 0} quotes',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Icon(
                                selected
                                    ? Icons.check_circle_rounded
                                    : Icons.swipe_up_alt_rounded,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
