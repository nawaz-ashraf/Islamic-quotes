import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/services/notification_service.dart';
import '../data/models/quote.dart';
import '../data/services/local_storage_service.dart';
import 'core_providers.dart';

class SettingsState {
  const SettingsState({required this.notificationsEnabled});

  final bool notificationsEnabled;

  SettingsState copyWith({bool? notificationsEnabled}) {
    return SettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier(this._storage, this._notifications)
      : super(SettingsState(notificationsEnabled: _storage.notificationsEnabled));

  final LocalStorageService _storage;
  final NotificationService _notifications;

  Future<void> toggleNotifications({
    required bool enabled,
    required List<Quote> availableQuotes,
  }) async {
    if (enabled) {
      final Quote quote = _notifications.pickRandomQuote(availableQuotes);
      await _notifications.scheduleDailyQuote(quote: quote);
    } else {
      await _notifications.cancelDailyQuote();
    }

    state = state.copyWith(notificationsEnabled: enabled);
    await _storage.setNotificationsEnabled(enabled);
  }
}

final StateNotifierProvider<SettingsNotifier, SettingsState> settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((Ref ref) {
  final storage = ref.watch(localStorageServiceProvider);
  final notifications = ref.watch(notificationServiceProvider);
  return SettingsNotifier(storage, notifications);
});
