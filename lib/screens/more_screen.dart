import 'package:flutter/material.dart';

import '../core/constants/more_section_content.dart';
import '../core/constants/visual_section_data.dart';
import '../widgets/category_card.dart';
import '../widgets/featured_quote_card.dart';
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
                final double tileHeight = crossAxisCount == 1 ? 170 : 196;
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
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Discover more Islamic resources',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Open a section to read verified reminders and references.',
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

                          return _MoreTileWithMeta(
                            section: section,
                            visual: visual,
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

class _MoreTileWithMeta extends StatelessWidget {
  const _MoreTileWithMeta({required this.section, required this.visual});

  final MoreSectionContent section;
  final MoreVisualData visual;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: CategoryCard(
            title: visual.title,
            icon: visual.icon,
            imageUrl: visual.imageUrl,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => MoreSectionDetailScreen(section: section),
                ),
              );
            },
          ),
        ),
        Positioned(
          right: 8,
          bottom: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.42),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${section.entries.length} items',
              style: theme.textTheme.labelSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MoreSectionDetailScreen extends StatelessWidget {
  const MoreSectionDetailScreen({required this.section, super.key});

  final MoreSectionContent section;

  @override
  Widget build(BuildContext context) {
    final bool isNamesSection = section.id == 'asma';

    return Scaffold(
      appBar: AppBar(title: Text(section.title)),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 20),
        itemCount: section.entries.length + 1,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (BuildContext context, int index) {
          if (index == section.entries.length) {
            return Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Note: Religious content is labeled with references where provided. For deeper study, consult qualified scholars and trusted classical sources.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            );
          }

          final MoreEntryContent entry = section.entries[index];
          if (isNamesSection) {
            return ListTile(
              tileColor: Theme.of(context).colorScheme.surfaceContainerLow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              dense: true,
              title: Text(entry.title),
              subtitle: Text(entry.source),
            );
          }

          return Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    entry.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    entry.text,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    entry.source,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
