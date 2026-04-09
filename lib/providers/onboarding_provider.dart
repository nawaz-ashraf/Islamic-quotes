import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/services/local_storage_service.dart';
import 'core_providers.dart';

class OnboardingNotifier extends StateNotifier<bool> {
  OnboardingNotifier(this._storage) : super(_storage.isOnboardingComplete);

  final LocalStorageService _storage;

  Future<void> completeOnboarding() async {
    state = true;
    await _storage.setOnboardingComplete(true);
  }
}

final StateNotifierProvider<OnboardingNotifier, bool> onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, bool>((Ref ref) {
  final storage = ref.watch(localStorageServiceProvider);
  return OnboardingNotifier(storage);
});
