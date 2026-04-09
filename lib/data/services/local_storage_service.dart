import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constants.dart';

class LocalStorageService {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get isOnboardingComplete => _prefs.getBool(AppConstants.onboardingCompleteKey) ?? false;

  Future<void> setOnboardingComplete(bool value) {
    return _prefs.setBool(AppConstants.onboardingCompleteKey, value);
  }

  Set<int> get favoriteQuoteIds {
    final List<String> rawIds = _prefs.getStringList(AppConstants.favoritesKey) ?? <String>[];
    return rawIds.map(int.tryParse).whereType<int>().toSet();
  }

  Future<void> saveFavoriteQuoteIds(Set<int> ids) {
    final List<String> serialized = ids.map((int id) => id.toString()).toList()..sort();
    return _prefs.setStringList(AppConstants.favoritesKey, serialized);
  }

  ThemeMode get themeMode {
    final String mode = _prefs.getString(AppConstants.themeModeKey) ?? 'system';
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) {
    final String serialized = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    return _prefs.setString(AppConstants.themeModeKey, serialized);
  }

  bool get notificationsEnabled => _prefs.getBool(AppConstants.notificationsEnabledKey) ?? true;

  Future<void> setNotificationsEnabled(bool enabled) {
    return _prefs.setBool(AppConstants.notificationsEnabledKey, enabled);
  }
}
