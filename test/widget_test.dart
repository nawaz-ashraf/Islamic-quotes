import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:islamic_quotes_app/data/services/local_storage_service.dart';
import 'package:islamic_quotes_app/main.dart';
import 'package:islamic_quotes_app/providers/core_providers.dart';

class _FakeLocalStorageService extends LocalStorageService {
  ThemeMode _themeMode = ThemeMode.system;
  bool _onboardingComplete = false;
  bool _notificationsEnabled = true;
  Set<int> _favorites = <int>{};

  @override
  Future<void> init() async {
    // No-op for tests.
  }

  @override
  bool get isOnboardingComplete => _onboardingComplete;

  @override
  Future<void> setOnboardingComplete(bool value) async {
    _onboardingComplete = value;
  }

  @override
  Set<int> get favoriteQuoteIds => _favorites;

  @override
  Future<void> saveFavoriteQuoteIds(Set<int> ids) async {
    _favorites = ids;
  }

  @override
  ThemeMode get themeMode => _themeMode;

  @override
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
  }

  @override
  bool get notificationsEnabled => _notificationsEnabled;

  @override
  Future<void> setNotificationsEnabled(bool enabled) async {
    _notificationsEnabled = enabled;
  }
}

void main() {
  testWidgets('App boots to splash', (WidgetTester tester) async {
    final LocalStorageService fakeStorage = _FakeLocalStorageService();

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          localStorageServiceProvider.overrideWithValue(fakeStorage),
        ],
        child: const IslamicQuotesApp(),
      ),
    );

    // SplashScreen shows app title immediately.
    expect(find.text('Sakinah'), findsWidgets);

    // Let the splash delay elapse and navigation complete.
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // With onboarding not completed, we should land on onboarding.
    expect(find.text('Welcome to Sakinah'), findsOneWidget);
  });
}
