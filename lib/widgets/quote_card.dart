import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/models/quote.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({
    required this.quote,
    required this.isFavorite,
    required this.onFavorite,
    required this.onTap,
    required this.onLongPress,
    super.key,
  });

  final Quote quote;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  bool _shouldShowSource(String source) {
    final String normalized =
        source.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim();

    if (normalized.isEmpty) {
      return false;
    }

    // Feed UX: hide the auto-generated attribution label.
    if (normalized == 'general islamic reminder' ||
        normalized == 'general islamic remainder') {
      return false;
    }

    return true;
  }

  List<Color> _gradientForCategory(String category, bool dark) {
    switch (category) {
      case 'Hope':
        return dark
            ? <Color>[const Color(0xFF152736), const Color(0xFF1F425C)]
            : <Color>[const Color(0xFFE7F2FF), const Color(0xFFD2E9FF)];
      case 'Patience':
        return dark
            ? <Color>[const Color(0xFF31253A), const Color(0xFF443152)]
            : <Color>[const Color(0xFFF7ECFF), const Color(0xFFECDCFD)];
      case 'Gratitude':
        return dark
            ? <Color>[const Color(0xFF44320E), const Color(0xFF5C4516)]
            : <Color>[const Color(0xFFFFF6DD), const Color(0xFFF9EBBE)];
      case 'Prayer':
        return dark
            ? <Color>[const Color(0xFF16362D), const Color(0xFF205042)]
            : <Color>[const Color(0xFFE2F9F0), const Color(0xFFCDEFD9)];
      case 'Quran':
        return dark
            ? <Color>[const Color(0xFF1C2F47), const Color(0xFF2A486D)]
            : <Color>[const Color(0xFFDDEBFF), const Color(0xFFCDDEFF)];
      default:
        return dark
            ? <Color>[const Color(0xFF1C2E29), const Color(0xFF28423A)]
            : <Color>[const Color(0xFFE8F6EF), const Color(0xFFD5EEDF)];
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final String source = quote.source.trim();
    final bool showSource = _shouldShowSource(source);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: _gradientForCategory(quote.category, isDark),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final bool compact =
                  constraints.maxHeight < 620 || constraints.maxWidth < 360;
              final double quoteFontSize = compact ? 31 : 38;
              final TextStyle urduStyle = GoogleFonts.getFont(
                'Noto Nastaliq Urdu',
                fontSize: compact ? 24 : 27,
                height: compact ? 1.8 : 1.9,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.primary
                    .withValues(alpha: isDark ? 0.9 : 0.95),
              );

              return Material(
                color: theme.colorScheme.surface
                    .withValues(alpha: isDark ? 0.28 : 0.64),
                borderRadius: BorderRadius.circular(28),
                child: InkWell(
                  borderRadius: BorderRadius.circular(28),
                  onTap: onTap,
                  onLongPress: onLongPress,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      compact ? 14 : 18,
                      compact ? 14 : 16,
                      compact ? 14 : 18,
                      compact ? 12 : 14,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: <Widget>[
                                  Chip(
                                    label: Text(quote.category),
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  Chip(
                                    label: const Text('Daily Reflection'),
                                    visualDensity: VisualDensity.compact,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton.filledTonal(
                              onPressed: onFavorite,
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return SingleChildScrollView(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: constraints.maxHeight,
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            Icons.format_quote_rounded,
                                            size: compact ? 32 : 40,
                                            color: theme.colorScheme.primary
                                                .withValues(alpha: 0.65),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            quote.textEn,
                                            style: theme
                                                .textTheme.headlineMedium
                                                ?.copyWith(
                                              fontSize: quoteFontSize,
                                              height: 1.16,
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
                                          if (showSource) ...<Widget>[
                                            const SizedBox(height: 18),
                                            Text(
                                              source,
                                              style: theme.textTheme.titleMedium
                                                  ?.copyWith(
                                                fontSize: compact ? 14 : 15,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                          ] else ...<Widget>[
                                            const SizedBox(height: 8),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
