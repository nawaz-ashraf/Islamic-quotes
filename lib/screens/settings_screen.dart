import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/quote.dart';
import '../providers/quote_feed_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final ThemeMode themeMode = ref.watch(themeModeProvider);
    final SettingsState settings = ref.watch(settingsProvider);
    final List<Quote> quotes =
        ref.watch(quoteFeedProvider.select((QuoteFeedState s) => s.allQuotes));

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 8, 14, 18),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Personalize your reading experience while keeping daily reminders gentle and focused.',
              style: theme.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: SwitchListTile.adaptive(
              title: const Text('Dark mode'),
              subtitle: const Text('Enable a calm dark reading experience.'),
              value: themeMode == ThemeMode.dark,
              onChanged: (bool enabled) {
                ref
                    .read(themeModeProvider.notifier)
                    .setMode(enabled ? ThemeMode.dark : ThemeMode.light);
              },
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: SwitchListTile.adaptive(
              title: const Text('Daily quote notification'),
              subtitle: const Text('Receive one Islamic quote every day.'),
              value: settings.notificationsEnabled,
              onChanged: (bool enabled) async {
                await ref.read(settingsProvider.notifier).toggleNotifications(
                      enabled: enabled,
                      availableQuotes: quotes,
                    );

                if (!context.mounted) {
                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      enabled
                          ? 'Daily notifications enabled.'
                          : 'Daily notifications disabled.',
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          const Card(
            child: ListTile(
              title: Text('About'),
              subtitle: Text(
                'Islamic Quotes\nA premium offline Islamic quotes app with reels-style feed, favorites, categories, and daily reminders.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
