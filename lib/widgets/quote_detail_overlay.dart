import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/models/quote.dart';

class QuoteDetailOverlay extends StatelessWidget {
  const QuoteDetailOverlay({
    required this.quote,
    required this.isFavorite,
    required this.onFavorite,
    required this.onCopy,
    required this.onShare,
    super.key,
  });

  final Quote quote;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onCopy;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle urduStyle = GoogleFonts.getFont(
      'Noto Nastaliq Urdu',
      fontSize: 29,
      height: 1.9,
      fontWeight: FontWeight.w500,
      color: theme.colorScheme.primary,
    );

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outline.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                decoration: BoxDecoration(
                  color:
                      theme.colorScheme.primaryContainer.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  quote.category,
                  style: theme.textTheme.labelLarge,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                quote.textEn,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 36,
                  height: 1.18,
                ),
              ),
              const SizedBox(height: 12),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    quote.textUr,
                    textAlign: TextAlign.right,
                    style: urduStyle,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                quote.source,
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: <Widget>[
                  FilledButton.icon(
                    onPressed: onFavorite,
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                    ),
                    label: Text(isFavorite ? 'Saved' : 'Save'),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: onCopy,
                    icon: const Icon(Icons.copy_rounded),
                    label: const Text('Copy'),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: onShare,
                    icon: const Icon(Icons.share_rounded),
                    label: const Text('Share'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
