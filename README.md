# Sakinah (Flutter)

A production-style Flutter Android app with a full-screen vertical quote feed inspired by reels UX, designed for a calm Islamic reading experience.

## Features

- Full-screen vertical quote feed using `PageView.builder`
- Offline-first quote data from `assets/quotes.json`
- Favorites with persistence via `shared_preferences`
- Category filtering
- Native share and clipboard copy
- Daily local quote notification (toggle in settings)
- Light and dark mode (Material 3)
- Splash + onboarding flow
- 300+ offline quote feed (with safe reminder expansion)
- More section with curated Islamic resources:
   - 99 Names of Allah
   - Daily Duas
   - Kalima
   - Quran Verses
   - Hadith
   - Islamic Reminders

## Project Architecture

- `lib/data`: models and data services
- `lib/core`: theme, constants, notification service
- `lib/providers`: Riverpod notifiers/providers
- `lib/screens`: feature screens (Home, Categories, Favorites, More, Settings)
- `lib/widgets`: reusable UI components

## Run Instructions

1. Ensure Flutter stable is installed and Android SDK is configured.
2. Open this folder in your IDE.
3. If platform folders are missing, generate Android scaffolding once:

   `flutter create . --platforms=android`

4. Install dependencies:

   `flutter pub get`

5. Run on an Android emulator/device:

   `flutter run`

## Notes

- For Android 13+ notifications, runtime permission is requested by the app.
- Quote data is local and works fully offline.
