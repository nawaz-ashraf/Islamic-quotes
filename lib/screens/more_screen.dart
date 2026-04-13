import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/more_section_content.dart';
import '../core/constants/visual_section_data.dart';
import '../widgets/featured_quote_card.dart';
import '../widgets/more_section_card.dart';
import '../widgets/section_header.dart';
import 'settings_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          SectionHeader(
            title: 'More',
            leadingIcon: Icons.widgets_rounded,
            trailing: _HeaderSettingsButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const SettingsScreen(),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final int crossAxisCount = constraints.maxWidth >= 1024
                    ? 3
                    : (constraints.maxWidth >= 390 ? 2 : 1);

                final double spacing = 12;
                final double tileHeight = crossAxisCount == 1 ? 156 : 186;
                final double tileWidth = (constraints.maxWidth -
                        32 -
                        (crossAxisCount - 1) * spacing) /
                    crossAxisCount;

                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FeaturedQuoteCard(
                        quote: VisualSectionData.moreBanner.quote,
                        source: VisualSectionData.moreBanner.source,
                        imageUrl: VisualSectionData.moreBanner.imageUrl,
                        lightMode: true,
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Discover authentic Islamic resources',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Open a section to explore reliable knowledge in a calm, focused layout.',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      GridView.builder(
                        itemCount: MoreSectionData.sections.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: spacing,
                          mainAxisSpacing: spacing,
                          childAspectRatio: tileWidth / tileHeight,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final MoreSectionContent section =
                              MoreSectionData.sections[index];
                          final MoreVisualData visual =
                              VisualSectionData.moreBySectionId[section.id] ??
                                  MoreVisualData(
                                    sectionId: section.id,
                                    title: section.title,
                                    icon: section.icon,
                                    imageUrl:
                                        VisualSectionData.moreBanner.imageUrl,
                                  );

                          return _MoreTileCard(
                            section: section,
                            visual: visual,
                            index: index,
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderSettingsButton extends StatelessWidget {
  const _HeaderSettingsButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        tooltip: 'Settings',
        onPressed: onPressed,
        icon: const Icon(Icons.settings_outlined, color: Colors.white),
        splashRadius: 22,
        padding: EdgeInsets.zero,
      ),
    );
  }
}

class _MoreTileCard extends StatelessWidget {
  const _MoreTileCard({
    required this.section,
    required this.visual,
    required this.index,
  });

  final MoreSectionContent section;
  final MoreVisualData visual;
  final int index;

  static const List<Color> _accentPalette = <Color>[
    Color(0xFF14815D),
    Color(0xFF0A7A80),
    Color(0xFF2E6BA8),
    Color(0xFF7255AA),
    Color(0xFF8C6B2C),
    Color(0xFF2E8C6B),
  ];

  Color _accentForSection() {
    switch (section.id) {
      case 'asma':
        return const Color(0xFF0E7A5A);
      case 'duas':
        return const Color(0xFF0B7D80);
      case 'kalima':
        return const Color(0xFF6B53A6);
      case 'pillars':
        return const Color(0xFF2D6EA5);
      case 'hadith':
        return const Color(0xFF8C6B2C);
      case 'reminders':
        return const Color(0xFF2F8F6D);
      default:
        return _accentPalette[index % _accentPalette.length];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MoreSectionCard(
      title: visual.title,
      icon: visual.icon,
      accentColor: _accentForSection(),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => MoreSectionDetailScreen(section: section),
          ),
        );
      },
    );
  }
}

class MoreSectionDetailScreen extends StatelessWidget {
  const MoreSectionDetailScreen({required this.section, super.key});

  final MoreSectionContent section;

  @override
  Widget build(BuildContext context) {
    final bool hasBottomNote =
        section.bottomNote != null && section.bottomNote!.trim().isNotEmpty;
    final bool isArabicRichSection =
        section.layout == MoreSectionLayout.arabicWithUrdu;

    return Scaffold(
      appBar: AppBar(title: Text(section.title), centerTitle: false),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 20),
        itemCount: section.entries.length + (hasBottomNote ? 1 : 0),
        separatorBuilder: (_, __) =>
            SizedBox(height: isArabicRichSection ? 14 : 10),
        itemBuilder: (BuildContext context, int index) {
          if (hasBottomNote && index == section.entries.length) {
            return Container(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withValues(alpha: 0.30),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.16),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Icon(Icons.info_outline_rounded, size: 17),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      section.bottomNote!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            );
          }

          final MoreEntryContent entry = section.entries[index];

          switch (section.layout) {
            case MoreSectionLayout.names:
              return _AsmaNameCard(entry: entry);
            case MoreSectionLayout.arabicWithUrdu:
              return _ArabicUrduContentCard(entry: entry);
            case MoreSectionLayout.info:
              return _InfoContentCard(entry: entry, fallbackIcon: section.icon);
          }
        },
      ),
    );
  }
}

class _AsmaNameCard extends StatelessWidget {
  const _AsmaNameCard({required this.entry});

  final MoreEntryContent entry;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color:
                    theme.colorScheme.primaryContainer.withValues(alpha: 0.70),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                entry.title,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      entry.primaryText,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.getFont(
                        'Noto Naskh Arabic',
                        fontSize: 32,
                        height: 1.35,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0E3B31),
                      ),
                    ),
                  ),
                  if (_isNotBlank(entry.secondaryText)) ...<Widget>[
                    const SizedBox(height: 3),
                    Text(
                      entry.secondaryText!,
                      textAlign: TextAlign.right,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color:
                            theme.colorScheme.primary.withValues(alpha: 0.86),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArabicUrduContentCard extends StatelessWidget {
  const _ArabicUrduContentCard({required this.entry});

  final MoreEntryContent entry;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              entry.title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                entry.primaryText,
                textAlign: TextAlign.right,
                softWrap: true,
                style: GoogleFonts.getFont(
                  'Noto Naskh Arabic',
                  fontSize: 27,
                  height: 1.58,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF103D32),
                ),
              ),
            ),
            if (_isNotBlank(entry.secondaryText)) ...<Widget>[
              const SizedBox(height: 12),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  entry.secondaryText!,
                  textAlign: TextAlign.right,
                  softWrap: true,
                  style: GoogleFonts.getFont(
                    'Noto Nastaliq Urdu',
                    fontSize: 18,
                    height: 1.9,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.88),
                  ),
                ),
              ),
            ],
            if (_isNotBlank(entry.reference)) ...<Widget>[
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Icon(Icons.bookmark_border_rounded, size: 15),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      entry.reference!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _InfoContentCard extends StatelessWidget {
  const _InfoContentCard({required this.entry, required this.fallbackIcon});

  final MoreEntryContent entry;
  final IconData fallbackIcon;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final IconData icon = entry.icon ?? fallbackIcon;

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer
                        .withValues(alpha: 0.72),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 20, color: theme.colorScheme.primary),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    entry.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              entry.primaryText,
              style: theme.textTheme.bodyMedium,
            ),
            if (_isNotBlank(entry.secondaryText)) ...<Widget>[
              const SizedBox(height: 8),
              Text(
                entry.secondaryText!,
                style: theme.textTheme.bodySmall,
              ),
            ],
            if (_isNotBlank(entry.reference)) ...<Widget>[
              const SizedBox(height: 8),
              Text(
                entry.reference!,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

bool _isNotBlank(String? value) {
  return value != null && value.trim().isNotEmpty;
}
