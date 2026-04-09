import 'package:flutter/material.dart';

class MoreSectionContent {
  const MoreSectionContent({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.entries,
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final List<MoreEntryContent> entries;
}

class MoreEntryContent {
  const MoreEntryContent({
    required this.title,
    required this.text,
    required this.source,
  });

  final String title;
  final String text;
  final String source;
}

class MoreSectionData {
  MoreSectionData._();

  static final List<String> _asmaNames = <String>[
    'Ar Rahmaan',
    'Ar Raheem',
    'Al Malik',
    'Al Quddus',
    'As Salaam',
    'Al Mu\'min',
    'Al Muhaymin',
    'Al Azeez',
    'Al Jabbaar',
    'Al Mutakabbir',
    'Al Khaaliq',
    'Al Baari',
    'Al Musawwir',
    'Al Ghaffaar',
    'Al Qahhaar',
    'Al Wahhaab',
    'Ar Razzaaq',
    'Al Fattaah',
    'Al \`Aleem',
    'Al Qaabid',
    'Al Baasit',
    'Al Khaafid',
    'Ar Raafi\'',
    'Al Mu\'iz',
    'Al Mudhil',
    'As Samee\'',
    'Al Baseer',
    'Al Hakam',
    'Al \`Adl',
    'Al Lateef',
    'Al Khabeer',
    'Al Haleem',
    'Al \`Azeem',
    'Al Ghafoor',
    'Ash Shakoor',
    'Al \`Aliyy',
    'Al Kabeer',
    'Al Hafeez',
    'Al Muqeet',
    'Al Haseeb',
    'Al Jaleel',
    'Al Kareem',
    'Ar Raqeeb',
    'Al Mujeeb',
    'Al Waasi\'',
    'Al Hakeem',
    'Al Wudood',
    'Al Majeed',
    'Al Baa\'ith',
    'Ash Shaheed',
    'Al Haqq',
    'Al Wakeel',
    'Al Qawiyy',
    'Al Mateen',
    'Al Waliyy',
    'Al Hameed',
    'Al Muhsi',
    'Al Mubdi',
    'Al Mu\'eed',
    'Al Muhiy',
    'Al Mumeet',
    'Al Haiyy',
    'Al Qayyoom',
    'Al Waajid',
    'Al Maajid',
    'Al Waahid',
    'Al Ahad',
    'As Samad',
    'Al Qaadir',
    'Al Muqtadir',
    'Al Muqaddim',
    'Al Mu\'akhir',
    'Al Awwal',
    'Al Aakhir',
    'Az Zaahir',
    'Al Baatin',
    'Al Waali',
    'Al Muta\'ali',
    'Al Barr',
    'At Tawwaab',
    'Al Muntaqim',
    'Al Afuww',
    'Ar Ra\'oof',
    'Maalik Ul Mulk',
    'Dhu Al Jalaali Wa Al Ikraam',
    'Al Muqsit',
    'Al Jaami\'',
    'Al Ghaniyy',
    'Al Mughni',
    'Al Maani\'',
    'Ad Daarr',
    'An Naafi\'',
    'An Noor',
    'Al Haadi',
    'Al Badi\'',
    'Al Baaqi',
    'Al Waarith',
    'Ar Rasheed',
    'As Saboor',
  ];

  static List<MoreEntryContent> get asmaUlHusnaEntries {
    return _asmaNames
        .asMap()
        .entries
        .map(
          (MapEntry<int, String> e) => MoreEntryContent(
            title: '${e.key + 1}. ${e.value}',
            text: 'Name of Allah (Asma ul Husna).',
            source: 'Source: Aladhan AsmaAlHusna API',
          ),
        )
        .toList(growable: false);
  }

  static const List<MoreEntryContent> duasEntries = <MoreEntryContent>[
    MoreEntryContent(
      title: 'Dua from Quran 2:201',
      text:
          'Our Lord! Grant us the good of this world and the Hereafter, and protect us from the torment of the Fire.',
      source: 'Quran 2:201 (translation source: Quran.com)',
    ),
    MoreEntryContent(
      title: 'Dua from Quran 20:114',
      text: 'My Lord, increase me in knowledge.',
      source: 'Quran 20:114 (translation source: Quran.com)',
    ),
  ];

  static const List<MoreEntryContent> kalimaEntries = <MoreEntryContent>[
    MoreEntryContent(
      title: 'Kalima / Shahada',
      text: 'La ilaha illa Allah, Muhammadur Rasul Allah.',
      source: 'Declaration of faith (Shahada)',
    ),
    MoreEntryContent(
      title: 'Meaning',
      text:
          'There is no deity worthy of worship except Allah, and Muhammad is the Messenger of Allah.',
      source: 'Essential Islamic testimony of faith',
    ),
  ];

  static const List<MoreEntryContent> quranVerseEntries = <MoreEntryContent>[
    MoreEntryContent(
      title: 'Ease after hardship',
      text: 'Indeed, with hardship comes ease.',
      source: 'Quran 94:6',
    ),
    MoreEntryContent(
      title: 'Patience and prayer',
      text: 'Allah is with those who are patient.',
      source: 'Quran 2:153',
    ),
    MoreEntryContent(
      title: 'Do not despair',
      text: 'Do not despair of the mercy of Allah.',
      source: 'Quran 39:53',
    ),
    MoreEntryContent(
      title: 'Hearts find comfort',
      text: 'Surely in the remembrance of Allah do hearts find comfort.',
      source: 'Quran 13:28 (translation source: Quran.com)',
    ),
  ];

  static const List<MoreEntryContent> hadithEntries = <MoreEntryContent>[
    MoreEntryContent(
      title: 'Intentions',
      text: 'Actions are judged by intentions.',
      source: 'Sahih al-Bukhari 1; Sahih Muslim 1907a',
    ),
    MoreEntryContent(
      title: 'Speak good or remain silent',
      text:
          'Whoever believes in Allah and the Last Day should speak good or keep silent.',
      source: 'Sahih al-Bukhari 6018; Sahih Muslim 47a',
    ),
    MoreEntryContent(
      title: 'Learn and teach Quran',
      text: 'The best among you are those who learn the Quran and teach it.',
      source: 'Sahih al-Bukhari 5027',
    ),
    MoreEntryContent(
      title: 'Stranger in this world',
      text: 'Be in this world as if you were a stranger or a traveler.',
      source: 'Sahih al-Bukhari 6416',
    ),
    MoreEntryContent(
      title: 'Gentleness',
      text: 'Allah is kind and He loves kindness.',
      source: 'Sahih Muslim 2593',
    ),
  ];

  static const List<MoreEntryContent> reminderEntries = <MoreEntryContent>[
    MoreEntryContent(
      title: 'Daily sincerity',
      text: 'Begin each day with a sincere intention to please Allah.',
      source: 'General Islamic reminder',
    ),
    MoreEntryContent(
      title: 'Steady prayer',
      text: 'Guard your prayers even on difficult days.',
      source: 'General Islamic reminder',
    ),
    MoreEntryContent(
      title: 'Mercy in character',
      text: 'Let mercy shape your words and decisions.',
      source: 'General Islamic reminder',
    ),
    MoreEntryContent(
      title: 'Patience in trials',
      text: 'Patience is not passive; it is active trust in Allah.',
      source: 'General Islamic reminder',
    ),
    MoreEntryContent(
      title: 'Repent often',
      text: 'Turn back to Allah often with humility and hope.',
      source: 'General Islamic reminder',
    ),
    MoreEntryContent(
      title: 'Gratitude practice',
      text: 'Write down one blessing each day and thank Allah for it.',
      source: 'General Islamic reminder',
    ),
  ];

  static final List<MoreSectionContent> sections = <MoreSectionContent>[
    MoreSectionContent(
      id: 'asma',
      title: '99 Names of Allah',
      subtitle: 'Reflect on Asma ul Husna with reverence and calm.',
      icon: Icons.stars_rounded,
      entries: asmaUlHusnaEntries,
    ),
    const MoreSectionContent(
      id: 'duas',
      title: 'Duas',
      subtitle: 'Short, verified duas with clear Quran references.',
      icon: Icons.pan_tool_alt_rounded,
      entries: duasEntries,
    ),
    const MoreSectionContent(
      id: 'kalima',
      title: 'Kalima',
      subtitle: 'Core declaration of Islamic faith.',
      icon: Icons.flag_circle_rounded,
      entries: kalimaEntries,
    ),
    const MoreSectionContent(
      id: 'quran',
      title: 'Quran Verses',
      subtitle: 'Selected verses for reflection and encouragement.',
      icon: Icons.menu_book_rounded,
      entries: quranVerseEntries,
    ),
    const MoreSectionContent(
      id: 'hadith',
      title: 'Hadith',
      subtitle: 'Authentic hadith with references for clarity.',
      icon: Icons.auto_stories_rounded,
      entries: hadithEntries,
    ),
    const MoreSectionContent(
      id: 'reminders',
      title: 'Islamic Reminders',
      subtitle: 'Practical spiritual reminders for daily living.',
      icon: Icons.lightbulb_outline_rounded,
      entries: reminderEntries,
    ),
  ];
}
