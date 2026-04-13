import 'package:flutter/material.dart';

class FeaturedBannerData {
  const FeaturedBannerData({
    required this.quote,
    required this.source,
    required this.imageUrl,
  });

  final String quote;
  final String source;
  final String imageUrl;
}

class CategoryVisualData {
  const CategoryVisualData({
    required this.category,
    required this.title,
    required this.icon,
    required this.imageUrl,
  });

  final String category;
  final String title;
  final IconData icon;
  final String imageUrl;
}

class MoreVisualData {
  const MoreVisualData({
    required this.sectionId,
    required this.title,
    required this.icon,
    required this.imageUrl,
  });

  final String sectionId;
  final String title;
  final IconData icon;
  final String imageUrl;
}

class VisualSectionData {
  VisualSectionData._();

  static const FeaturedBannerData categoriesBanner = FeaturedBannerData(
    quote: 'Take one step toward Allah, and His mercy comes to meet you.',
    source: 'Spiritual Reflection',
    imageUrl:
        'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?auto=format&fit=crop&w=1400&q=80',
  );

  static const FeaturedBannerData moreBanner = FeaturedBannerData(
    quote:
        'Knowledge without reflection is incomplete, and reflection without action is empty.',
    source: 'Featured Wisdom',
    imageUrl:
        'https://images.unsplash.com/photo-1507692049790-de58290a4334?auto=format&fit=crop&w=1400&q=80',
  );

  static const List<CategoryVisualData> categoryTiles = <CategoryVisualData>[
    CategoryVisualData(
      category: 'Faith',
      title: 'Faith',
      icon: Icons.mosque_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1519817650390-64a93db511aa?auto=format&fit=crop&w=900&q=80',
    ),
    CategoryVisualData(
      category: 'Patience',
      title: 'Patience',
      icon: Icons.hourglass_bottom_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1482192596544-9eb780fc7f66?auto=format&fit=crop&w=900&q=80',
    ),
    CategoryVisualData(
      category: 'Gratitude',
      title: 'Gratitude',
      icon: Icons.favorite_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1492496913980-501348b61469?auto=format&fit=crop&w=900&q=80',
    ),
    CategoryVisualData(
      category: 'Prayer',
      title: 'Prayer',
      icon: Icons.pan_tool_alt_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1528744598421-b7b93e12df3e?auto=format&fit=crop&w=900&q=80',
    ),
    CategoryVisualData(
      category: 'Hope',
      title: 'Hope',
      icon: Icons.wb_sunny_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1523287562758-66c7fc58967f?auto=format&fit=crop&w=900&q=80',
    ),
    CategoryVisualData(
      category: 'Mercy',
      title: 'Mercy',
      icon: Icons.volunteer_activism_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1453738773917-9c3eff1db985?auto=format&fit=crop&w=900&q=80',
    ),
    CategoryVisualData(
      category: 'Forgiveness',
      title: 'Forgiveness',
      icon: Icons.handshake_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1441716844725-09cedc13a4e7?auto=format&fit=crop&w=900&q=80',
    ),
    CategoryVisualData(
      category: 'Life',
      title: 'Life',
      icon: Icons.landscape_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1477414348463-c0eb7f1359b6?auto=format&fit=crop&w=900&q=80',
    ),
    CategoryVisualData(
      category: 'Character',
      title: 'Character',
      icon: Icons.verified_user_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=900&q=80',
    ),
    CategoryVisualData(
      category: 'Reflection',
      title: 'Reflection',
      icon: Icons.self_improvement_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=900&q=80',
    ),
    CategoryVisualData(
      category: 'Quran',
      title: 'Quran',
      icon: Icons.menu_book_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1584286595398-a96fede9f6d2?auto=format&fit=crop&w=900&q=80',
    ),
    CategoryVisualData(
      category: 'Hadith',
      title: 'Hadith',
      icon: Icons.auto_stories_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=900&q=80',
    ),
  ];

  static const List<MoreVisualData> moreTiles = <MoreVisualData>[
    MoreVisualData(
      sectionId: 'asma',
      title: '99 Names of Allah',
      icon: Icons.stars_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1472145246862-b24cf25c4a36?auto=format&fit=crop&w=900&q=80',
    ),
    MoreVisualData(
      sectionId: 'duas',
      title: 'Duas',
      icon: Icons.pan_tool_alt_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1524492449090-1a0c3a198cf4?auto=format&fit=crop&w=900&q=80',
    ),
    MoreVisualData(
      sectionId: 'kalima',
      title: 'Kalima',
      icon: Icons.flag_circle_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1504473089979-b1c4993a9653?auto=format&fit=crop&w=900&q=80',
    ),
    MoreVisualData(
      sectionId: 'pillars',
      title: 'Pillars of Islam',
      icon: Icons.account_balance_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1519638399535-1b036603ac77?auto=format&fit=crop&w=900&q=80',
    ),
    MoreVisualData(
      sectionId: 'hadith',
      title: 'Hadith',
      icon: Icons.auto_stories_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1505666287802-931dc83a58bb?auto=format&fit=crop&w=900&q=80',
    ),
    MoreVisualData(
      sectionId: 'reminders',
      title: 'Islamic Reminders',
      icon: Icons.lightbulb_outline_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1464852045489-bccb7d17fe39?auto=format&fit=crop&w=900&q=80',
    ),
  ];

  static final Map<String, CategoryVisualData> categoryByName =
      <String, CategoryVisualData>{
    for (final CategoryVisualData item in categoryTiles) item.category: item,
  };

  static final Map<String, MoreVisualData> moreBySectionId =
      <String, MoreVisualData>{
    for (final MoreVisualData item in moreTiles) item.sectionId: item,
  };
}
