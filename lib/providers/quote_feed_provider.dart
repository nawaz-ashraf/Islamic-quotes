import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/quote.dart';
import '../data/services/local_storage_service.dart';
import '../data/services/quote_repository.dart';
import 'core_providers.dart';

class QuoteFeedState {
  const QuoteFeedState({
    required this.isLoading,
    required this.allQuotes,
    required this.favoriteIds,
    required this.selectedFeedCategory,
    required this.visibleCount,
    required this.initialFeedIndex,
    required this.isPaging,
  });

  factory QuoteFeedState.initial() {
    return const QuoteFeedState(
      isLoading: true,
      allQuotes: <Quote>[],
      favoriteIds: <int>{},
      selectedFeedCategory: null,
      visibleCount: 0,
      initialFeedIndex: 0,
      isPaging: false,
    );
  }

  final bool isLoading;
  final List<Quote> allQuotes;
  final Set<int> favoriteIds;
  final String? selectedFeedCategory;
  final int visibleCount;
  final int initialFeedIndex;
  final bool isPaging;

  List<Quote> get _filteredQuotes {
    if (selectedFeedCategory == null) {
      return allQuotes;
    }

    return allQuotes
        .where((Quote quote) => quote.category == selectedFeedCategory)
        .toList(growable: false);
  }

  bool get hasMore => visibleCount < _filteredQuotes.length;

  List<Quote> get feedQuotes {
    if (_filteredQuotes.isEmpty) {
      return const <Quote>[];
    }

    final int count = visibleCount.clamp(0, _filteredQuotes.length);
    return _filteredQuotes.take(count).toList(growable: false);
  }

  List<Quote> get favoriteQuotes => allQuotes
      .where((Quote quote) => favoriteIds.contains(quote.id))
      .toList(growable: false);

  QuoteFeedState copyWith({
    bool? isLoading,
    List<Quote>? allQuotes,
    Set<int>? favoriteIds,
    String? selectedFeedCategory,
    bool clearSelectedCategory = false,
    int? visibleCount,
    int? initialFeedIndex,
    bool? isPaging,
  }) {
    return QuoteFeedState(
      isLoading: isLoading ?? this.isLoading,
      allQuotes: allQuotes ?? this.allQuotes,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      selectedFeedCategory: clearSelectedCategory
          ? null
          : (selectedFeedCategory ?? this.selectedFeedCategory),
      visibleCount: visibleCount ?? this.visibleCount,
      initialFeedIndex: initialFeedIndex ?? this.initialFeedIndex,
      isPaging: isPaging ?? this.isPaging,
    );
  }
}

class QuoteFeedNotifier extends StateNotifier<QuoteFeedState> {
  QuoteFeedNotifier(this._repository, this._storage)
      : super(QuoteFeedState.initial()) {
    _initialize();
  }

  final QuoteRepository _repository;
  final LocalStorageService _storage;

  static const int _pageSize = 50;
  static const int _preloadThreshold = 6;

  Future<void> _initialize() async {
    try {
      final List<Quote> loadedQuotes = await _repository.loadQuotes();
      final Set<int> favorites = _storage.favoriteQuoteIds;

      final int randomInitialIndex =
          loadedQuotes.isEmpty ? 0 : Random().nextInt(loadedQuotes.length);

      final int initialCount =
          loadedQuotes.length < _pageSize ? loadedQuotes.length : _pageSize;
      final int adjustedInitialCount = (randomInitialIndex + 1) > initialCount
          ? (randomInitialIndex + 1)
          : initialCount;

      state = state.copyWith(
        isLoading: false,
        allQuotes: loadedQuotes,
        favoriteIds: favorites,
        visibleCount: adjustedInitialCount,
        initialFeedIndex: randomInitialIndex,
      );
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  bool isFavorite(int quoteId) => state.favoriteIds.contains(quoteId);

  Future<void> toggleFavorite(int quoteId) async {
    final Set<int> nextFavorites = <int>{...state.favoriteIds};
    if (!nextFavorites.add(quoteId)) {
      nextFavorites.remove(quoteId);
    }

    state = state.copyWith(favoriteIds: nextFavorites);
    await _storage.saveFavoriteQuoteIds(nextFavorites);
  }

  void setFeedCategory(String? category) {
    if (category == null) {
      final int maxCount = state.allQuotes.length;
      state = state.copyWith(
        clearSelectedCategory: true,
        visibleCount: maxCount < _pageSize ? maxCount : _pageSize,
      );
      return;
    }

    // Reset paging when switching category so the feed feels "fresh" and stays memory-light.
    final int filteredLen =
        state.allQuotes.where((Quote q) => q.category == category).length;
    final int initialCount = filteredLen < _pageSize ? filteredLen : _pageSize;
    state = state.copyWith(
      selectedFeedCategory: category,
      visibleCount: initialCount,
    );
  }

  Future<void> maybeLoadMore(int currentIndex) async {
    if (state.isLoading || state.isPaging || !state.hasMore) {
      return;
    }

    // When the user approaches the end, extend the list.
    final int remaining = state.feedQuotes.length - 1 - currentIndex;
    if (remaining > _preloadThreshold) {
      return;
    }

    state = state.copyWith(isPaging: true);

    // Compute next count based on current filter.
    final int filteredLen = state.selectedFeedCategory == null
        ? state.allQuotes.length
        : state.allQuotes
            .where(
                (Quote quote) => quote.category == state.selectedFeedCategory)
            .length;

    final int nextCount =
        (state.visibleCount + _pageSize).clamp(0, filteredLen);
    state = state.copyWith(visibleCount: nextCount, isPaging: false);
  }
}

final StateNotifierProvider<QuoteFeedNotifier, QuoteFeedState>
    quoteFeedProvider =
    StateNotifierProvider<QuoteFeedNotifier, QuoteFeedState>((Ref ref) {
  final repository = ref.watch(quoteRepositoryProvider);
  final storage = ref.watch(localStorageServiceProvider);
  return QuoteFeedNotifier(repository, storage);
});
