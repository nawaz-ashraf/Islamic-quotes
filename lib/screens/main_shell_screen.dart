import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/quote_feed_provider.dart';
import 'categories_screen.dart';
import 'favorites_screen.dart';
import 'home_feed_screen.dart';
import 'more_screen.dart';

class MainShellScreen extends ConsumerStatefulWidget {
  const MainShellScreen({super.key});

  @override
  ConsumerState<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends ConsumerState<MainShellScreen> {
  int _selectedIndex = 0;

  void _applyCategoryAndGoHome(String? category) {
    ref.read(quoteFeedProvider.notifier).setFeedCategory(category);
    setState(() => _selectedIndex = 0);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = <Widget>[
      const HomeFeedScreen(),
      CategoriesScreen(onApplyFilter: _applyCategoryAndGoHome),
      const FavoritesScreen(),
      const MoreScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int value) =>
            setState(() => _selectedIndex = value),
        destinations: const <NavigationDestination>[
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Feed'),
          NavigationDestination(
              icon: Icon(Icons.grid_view_rounded), label: 'Categories'),
          NavigationDestination(
              icon: Icon(Icons.favorite_border_rounded), label: 'Favorites'),
          NavigationDestination(
              icon: Icon(Icons.more_horiz_rounded), label: 'More'),
        ],
      ),
    );
  }
}
