import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../data/models/quote.dart';
import '../constants/app_constants.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  Future<void> init({bool requestPermission = false}) async {
    if (_isInitialized) {
      if (requestPermission) {
        await _plugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();
      }
      return;
    }

    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
    );

    await _plugin.initialize(initSettings);

    final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
        _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (requestPermission) {
      await androidPlugin?.requestNotificationsPermission();
    }

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'daily_quote_channel',
      'Daily Islamic Quote',
      description: 'One calming Islamic quote every day',
      importance: Importance.defaultImportance,
    );

    await androidPlugin?.createNotificationChannel(channel);
    _isInitialized = true;
  }

  Future<void> scheduleDailyQuote({required Quote quote}) async {
    await init(requestPermission: true);

    final String body = quote.shareBody;
    final NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_quote_channel',
        'Daily Islamic Quote',
        channelDescription: 'One calming Islamic quote every day',
        styleInformation: BigTextStyleInformation(body),
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
      ),
    );

    await _plugin.cancel(AppConstants.dailyNotificationId);
    await _plugin.periodicallyShow(
      AppConstants.dailyNotificationId,
      'Daily Islamic Reminder',
      body,
      RepeatInterval.daily,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  Future<void> cancelDailyQuote() {
    return _plugin.cancel(AppConstants.dailyNotificationId);
  }

  Quote pickRandomQuote(List<Quote> quotes) {
    if (quotes.isEmpty) {
      return const Quote(
        id: -1,
        textEn: 'Verily, in the remembrance of Allah do hearts find rest.',
        textUr: 'سن لو! دلوں کا اطمینان اللہ کے ذکر ہی میں ہے۔',
        source: 'Quran 13:28',
        category: 'Faith',
      );
    }

    return quotes[Random().nextInt(quotes.length)];
  }
}
