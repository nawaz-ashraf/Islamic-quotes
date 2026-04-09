import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/services/notification_service.dart';
import '../data/services/local_storage_service.dart';
import '../data/services/quote_repository.dart';

final Provider<LocalStorageService> localStorageServiceProvider =
    Provider<LocalStorageService>((Ref ref) {
  throw UnimplementedError('localStorageServiceProvider must be overridden in ProviderScope.');
});

final Provider<QuoteRepository> quoteRepositoryProvider = Provider<QuoteRepository>(
  (Ref ref) => QuoteRepository(rootBundle),
);

final Provider<NotificationService> notificationServiceProvider =
    Provider<NotificationService>((Ref ref) => NotificationService.instance);
