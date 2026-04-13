import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  AdService._();

  /// Use Google test ads in debug/profile builds (recommended).
  /// Release builds will use production IDs.
  static bool get useTestAds => !kReleaseMode;

  // Test IDs (official Google samples)
  static const String _androidAppIdTest =
      'ca-app-pub-3940256099942544~3347511713';
  static const String _iosAppIdTest = 'ca-app-pub-3940256099942544~1458002511';
  static const String _androidBannerTest =
      'ca-app-pub-3940256099942544/6300978111';
  static const String _iosBannerTest = 'ca-app-pub-3940256099942544/2934735716';
  static const String _androidInterstitialTest =
      'ca-app-pub-3940256099942544/1033173712';
  static const String _iosInterstitialTest =
      'ca-app-pub-3940256099942544/4411468910';

  // Production IDs
  static const String _androidAppIdProd =
      'ca-app-pub-4392358942856616~2605141325';
  static const String _iosAppIdProd = 'ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX';
  static const String _androidBannerProd =
      'ca-app-pub-4392358942856616/8893003065';
  static const String _iosBannerProd = 'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX';
  static const String _androidInterstitialProd =
      'ca-app-pub-4392358942856616/6165112388';
  static const String _iosInterstitialProd =
      'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX';

  static bool _initialized = false;
  static InterstitialAd? _interstitialAd;
  static int _interactionCount = 0;
  static int _nextInterstitialAt = _randomThreshold();
  static DateTime? _lastInterstitialShownAt;

  static const Duration _interstitialCooldown = Duration(minutes: 2);

  static bool get _supportsMobileAds {
    if (kIsWeb) {
      return false;
    }

    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  static String get appId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return useTestAds ? _androidAppIdTest : _androidAppIdProd;
    }

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return useTestAds ? _iosAppIdTest : _iosAppIdProd;
    }

    return '';
  }

  static String get bannerAdUnitId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return useTestAds ? _androidBannerTest : _androidBannerProd;
    }

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return useTestAds ? _iosBannerTest : _iosBannerProd;
    }

    return '';
  }

  static String get interstitialAdUnitId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return useTestAds ? _androidInterstitialTest : _androidInterstitialProd;
    }

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return useTestAds ? _iosInterstitialTest : _iosInterstitialProd;
    }

    return '';
  }

  static bool get supportsBannerAds {
    return _supportsMobileAds && bannerAdUnitId.isNotEmpty;
  }

  static bool get supportsInterstitialAds {
    return _supportsMobileAds && interstitialAdUnitId.isNotEmpty;
  }

  static Future<void> initialize() async {
    if (_initialized || !_supportsMobileAds) {
      return;
    }

    await MobileAds.instance.initialize();
    _initialized = true;
    _loadInterstitial();
  }

  static void registerInteraction() {
    if (!_initialized || !supportsInterstitialAds) {
      return;
    }

    _interactionCount += 1;
    if (_interactionCount < _nextInterstitialAt) {
      return;
    }

    _showInterstitialIfReady();
  }

  static void _showInterstitialIfReady() {
    final DateTime now = DateTime.now();

    if (_lastInterstitialShownAt != null &&
        now.difference(_lastInterstitialShownAt!) < _interstitialCooldown) {
      _resetInteractionWindow();
      return;
    }

    final InterstitialAd? ad = _interstitialAd;
    if (ad == null) {
      _resetInteractionWindow();
      _loadInterstitial();
      return;
    }

    _interstitialAd = null;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd dismissedAd) {
        dismissedAd.dispose();
        _loadInterstitial();
      },
      onAdFailedToShowFullScreenContent: (
        InterstitialAd failedAd,
        AdError error,
      ) {
        failedAd.dispose();
        _loadInterstitial();
      },
    );

    ad.show();
    _lastInterstitialShownAt = now;
    _resetInteractionWindow();
  }

  static void _loadInterstitial() {
    if (!supportsInterstitialAds) {
      return;
    }

    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd?.dispose();
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialAd = null;
        },
      ),
    );
  }

  static void dispose() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
  }

  static int _randomThreshold() {
    return 5 + Random().nextInt(3); // 5, 6, or 7 interactions.
  }

  static void _resetInteractionWindow() {
    _interactionCount = 0;
    _nextInterstitialAt = _randomThreshold();
  }
}
