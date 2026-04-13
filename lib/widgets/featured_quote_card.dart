import 'package:flutter/material.dart';

class FeaturedQuoteCard extends StatelessWidget {
  const FeaturedQuoteCard({
    required this.quote,
    required this.source,
    required this.imageUrl,
    this.lightMode = false,
    this.onTap,
    super.key,
  });

  final String quote;
  final String source;
  final String imageUrl;
  final bool lightMode;
  final VoidCallback? onTap;

  bool get _isNetworkImage {
    return imageUrl.startsWith('http://') || imageUrl.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    if (lightMode) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final bool compact =
                      constraints.maxHeight < 210 || constraints.maxWidth < 380;

                  return DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[Color(0xFFF3FBF8), Color(0xFFE7F4ED)],
                      ),
                      border: Border.all(
                        color:
                            theme.colorScheme.primary.withValues(alpha: 0.14),
                      ),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Positioned(
                          right: -24,
                          top: -20,
                          child: Icon(
                            Icons.mosque_rounded,
                            size: compact ? 110 : 138,
                            color: theme.colorScheme.primary
                                .withValues(alpha: 0.08),
                          ),
                        ),
                        Positioned(
                          left: 14,
                          bottom: 10,
                          child: Icon(
                            Icons.auto_awesome_rounded,
                            size: compact ? 34 : 42,
                            color: theme.colorScheme.primary
                                .withValues(alpha: 0.10),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            compact ? 14 : 18,
                            compact ? 14 : 16,
                            compact ? 14 : 18,
                            compact ? 12 : 14,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                child: Center(
                                  child: Text(
                                    quote,
                                    textAlign: TextAlign.center,
                                    maxLines: compact ? 4 : 5,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      color: const Color(0xFF14392E),
                                      fontSize: compact ? 24 : 29,
                                      fontWeight: FontWeight.w700,
                                      height: 1.22,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                source,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: const Color(0xFF245A48),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool compact =
                    constraints.maxHeight < 210 || constraints.maxWidth < 380;
                final double horizontalPadding = compact ? 14 : 18;
                final double verticalPadding = compact ? 12 : 16;
                final int quoteMaxLines = compact ? 3 : 4;

                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    _isNetworkImage
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _fallbackBackground(),
                          )
                        : Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _fallbackBackground(),
                          ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.black.withValues(alpha: 0.35),
                            Colors.black.withValues(alpha: 0.66),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        verticalPadding,
                        horizontalPadding,
                        verticalPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: Text(
                                quote,
                                textAlign: TextAlign.center,
                                maxLines: quoteMaxLines,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontSize: compact ? 20 : 28,
                                  height: 1.24,
                                  fontWeight: FontWeight.w700,
                                  shadows: const <Shadow>[
                                    Shadow(
                                      color: Colors.black54,
                                      blurRadius: 10,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            source,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.98),
                              fontWeight: FontWeight.w700,
                              shadows: const <Shadow>[
                                Shadow(
                                  color: Colors.black54,
                                  blurRadius: 6,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _fallbackBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF1E6A5A), Color(0xFF2B8A6D)],
        ),
      ),
    );
  }
}
