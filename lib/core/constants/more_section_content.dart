import 'package:flutter/material.dart';

enum MoreSectionLayout {
  names,
  arabicWithUrdu,
  info,
}

class MoreSectionContent {
  const MoreSectionContent({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.layout,
    required this.entries,
    this.bottomNote,
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final MoreSectionLayout layout;
  final List<MoreEntryContent> entries;
  final String? bottomNote;
}

class MoreEntryContent {
  const MoreEntryContent({
    required this.title,
    required this.primaryText,
    this.secondaryText,
    this.reference,
    this.icon,
  });

  final String title;
  final String primaryText;
  final String? secondaryText;
  final String? reference;
  final IconData? icon;
}

class MoreSectionData {
  MoreSectionData._();

  static final List<_AsmaName> _asmaNames = <_AsmaName>[
    const _AsmaName(arabic: 'ٱلرَّحْمَـٰنُ', transliteration: 'Ar-Rahman'),
    const _AsmaName(arabic: 'ٱلرَّحِيمُ', transliteration: 'Ar-Raheem'),
    const _AsmaName(arabic: 'ٱلْمَلِكُ', transliteration: 'Al-Malik'),
    const _AsmaName(arabic: 'ٱلْقُدُّوسُ', transliteration: 'Al-Quddus'),
    const _AsmaName(arabic: 'ٱلسَّلَامُ', transliteration: 'As-Salam'),
    const _AsmaName(arabic: 'ٱلْمُؤْمِنُ', transliteration: 'Al-Mu’min'),
    const _AsmaName(arabic: 'ٱلْمُهَيْمِنُ', transliteration: 'Al-Muhaymin'),
    const _AsmaName(arabic: 'ٱلْعَزِيزُ', transliteration: 'Al-Aziz'),
    const _AsmaName(arabic: 'ٱلْجَبَّارُ', transliteration: 'Al-Jabbar'),
    const _AsmaName(arabic: 'ٱلْمُتَكَبِّرُ', transliteration: 'Al-Mutakabbir'),
    const _AsmaName(arabic: 'ٱلْخَالِقُ', transliteration: 'Al-Khaliq'),
    const _AsmaName(arabic: 'ٱلْبَارِئُ', transliteration: 'Al-Bari’'),
    const _AsmaName(arabic: 'ٱلْمُصَوِّرُ', transliteration: 'Al-Musawwir'),
    const _AsmaName(arabic: 'ٱلْغَفَّارُ', transliteration: 'Al-Ghaffar'),
    const _AsmaName(arabic: 'ٱلْقَهَّارُ', transliteration: 'Al-Qahhar'),
    const _AsmaName(arabic: 'ٱلْوَهَّابُ', transliteration: 'Al-Wahhab'),
    const _AsmaName(arabic: 'ٱلرَّزَّاقُ', transliteration: 'Ar-Razzaq'),
    const _AsmaName(arabic: 'ٱلْفَتَّاحُ', transliteration: 'Al-Fattah'),
    const _AsmaName(arabic: 'ٱلْعَلِيمُ', transliteration: 'Al-‘Aleem'),
    const _AsmaName(arabic: 'ٱلْقَابِضُ', transliteration: 'Al-Qabid'),
    const _AsmaName(arabic: 'ٱلْبَاسِطُ', transliteration: 'Al-Basit'),
    const _AsmaName(arabic: 'ٱلْخَافِضُ', transliteration: 'Al-Khafid'),
    const _AsmaName(arabic: 'ٱلرَّافِعُ', transliteration: 'Ar-Rafi’'),
    const _AsmaName(arabic: 'ٱلْمُعِزُّ', transliteration: 'Al-Mu’izz'),
    const _AsmaName(arabic: 'ٱلْمُذِلُّ', transliteration: 'Al-Mudhill'),
    const _AsmaName(arabic: 'ٱلسَّمِيعُ', transliteration: 'As-Sami’'),
    const _AsmaName(arabic: 'ٱلْبَصِيرُ', transliteration: 'Al-Basir'),
    const _AsmaName(arabic: 'ٱلْحَكَمُ', transliteration: 'Al-Hakam'),
    const _AsmaName(arabic: 'ٱلْعَدْلُ', transliteration: 'Al-‘Adl'),
    const _AsmaName(arabic: 'ٱللَّطِيفُ', transliteration: 'Al-Latif'),
    const _AsmaName(arabic: 'ٱلْخَبِيرُ', transliteration: 'Al-Khabir'),
    const _AsmaName(arabic: 'ٱلْحَلِيمُ', transliteration: 'Al-Haleem'),
    const _AsmaName(arabic: 'ٱلْعَظِيمُ', transliteration: 'Al-‘Azeem'),
    const _AsmaName(arabic: 'ٱلْغَفُورُ', transliteration: 'Al-Ghafur'),
    const _AsmaName(arabic: 'ٱلشَّكُورُ', transliteration: 'Ash-Shakur'),
    const _AsmaName(arabic: 'ٱلْعَلِيُّ', transliteration: 'Al-‘Aliyy'),
    const _AsmaName(arabic: 'ٱلْكَبِيرُ', transliteration: 'Al-Kabir'),
    const _AsmaName(arabic: 'ٱلْحَفِيظُ', transliteration: 'Al-Hafiz'),
    const _AsmaName(arabic: 'ٱلْمُقِيتُ', transliteration: 'Al-Muqit'),
    const _AsmaName(arabic: 'ٱلْحَسِيبُ', transliteration: 'Al-Hasib'),
    const _AsmaName(arabic: 'ٱلْجَلِيلُ', transliteration: 'Al-Jalil'),
    const _AsmaName(arabic: 'ٱلْكَرِيمُ', transliteration: 'Al-Karim'),
    const _AsmaName(arabic: 'ٱلرَّقِيبُ', transliteration: 'Ar-Raqib'),
    const _AsmaName(arabic: 'ٱلْمُجِيبُ', transliteration: 'Al-Mujib'),
    const _AsmaName(arabic: 'ٱلْوَاسِعُ', transliteration: 'Al-Wasi’'),
    const _AsmaName(arabic: 'ٱلْحَكِيمُ', transliteration: 'Al-Hakeem'),
    const _AsmaName(arabic: 'ٱلْوَدُودُ', transliteration: 'Al-Wadud'),
    const _AsmaName(arabic: 'ٱلْمَجِيدُ', transliteration: 'Al-Majid'),
    const _AsmaName(arabic: 'ٱلْبَاعِثُ', transliteration: 'Al-Ba’ith'),
    const _AsmaName(arabic: 'ٱلشَّهِيدُ', transliteration: 'Ash-Shahid'),
    const _AsmaName(arabic: 'ٱلْحَقُّ', transliteration: 'Al-Haqq'),
    const _AsmaName(arabic: 'ٱلْوَكِيلُ', transliteration: 'Al-Wakil'),
    const _AsmaName(arabic: 'ٱلْقَوِيُّ', transliteration: 'Al-Qawiyy'),
    const _AsmaName(arabic: 'ٱلْمَتِينُ', transliteration: 'Al-Mateen'),
    const _AsmaName(arabic: 'ٱلْوَلِيُّ', transliteration: 'Al-Waliyy'),
    const _AsmaName(arabic: 'ٱلْحَمِيدُ', transliteration: 'Al-Hamid'),
    const _AsmaName(arabic: 'ٱلْمُحْصِي', transliteration: 'Al-Muhsi'),
    const _AsmaName(arabic: 'ٱلْمُبْدِئُ', transliteration: 'Al-Mubdi’'),
    const _AsmaName(arabic: 'ٱلْمُعِيدُ', transliteration: 'Al-Mu’id'),
    const _AsmaName(arabic: 'ٱلْمُحْيِي', transliteration: 'Al-Muhyi'),
    const _AsmaName(arabic: 'ٱلْمُمِيتُ', transliteration: 'Al-Mumeet'),
    const _AsmaName(arabic: 'ٱلْحَيُّ', transliteration: 'Al-Hayy'),
    const _AsmaName(arabic: 'ٱلْقَيُّومُ', transliteration: 'Al-Qayyum'),
    const _AsmaName(arabic: 'ٱلْوَاجِدُ', transliteration: 'Al-Wajid'),
    const _AsmaName(arabic: 'ٱلْمَاجِدُ', transliteration: 'Al-Majid'),
    const _AsmaName(arabic: 'ٱلْوَاحِدُ', transliteration: 'Al-Wahid'),
    const _AsmaName(arabic: 'ٱلْأَحَدُ', transliteration: 'Al-Ahad'),
    const _AsmaName(arabic: 'ٱلصَّمَدُ', transliteration: 'As-Samad'),
    const _AsmaName(arabic: 'ٱلْقَادِرُ', transliteration: 'Al-Qadir'),
    const _AsmaName(arabic: 'ٱلْمُقْتَدِرُ', transliteration: 'Al-Muqtadir'),
    const _AsmaName(arabic: 'ٱلْمُقَدِّمُ', transliteration: 'Al-Muqaddim'),
    const _AsmaName(arabic: 'ٱلْمُؤَخِّرُ', transliteration: 'Al-Mu’akhkhir'),
    const _AsmaName(arabic: 'ٱلْأَوَّلُ', transliteration: 'Al-Awwal'),
    const _AsmaName(arabic: 'ٱلْآخِرُ', transliteration: 'Al-Akhir'),
    const _AsmaName(arabic: 'ٱلظَّاهِرُ', transliteration: 'Az-Zahir'),
    const _AsmaName(arabic: 'ٱلْبَاطِنُ', transliteration: 'Al-Batin'),
    const _AsmaName(arabic: 'ٱلْوَالِي', transliteration: 'Al-Wali'),
    const _AsmaName(arabic: 'ٱلْمُتَعَالِي', transliteration: 'Al-Muta’ali'),
    const _AsmaName(arabic: 'ٱلْبَرُّ', transliteration: 'Al-Barr'),
    const _AsmaName(arabic: 'ٱلتَّوَّابُ', transliteration: 'At-Tawwab'),
    const _AsmaName(arabic: 'ٱلْمُنْتَقِمُ', transliteration: 'Al-Muntaqim'),
    const _AsmaName(arabic: 'ٱلْعَفُوُّ', transliteration: 'Al-‘Afuww'),
    const _AsmaName(arabic: 'ٱلرَّؤُوفُ', transliteration: 'Ar-Ra’uf'),
    const _AsmaName(
        arabic: 'مَالِكُ ٱلْمُلْكِ', transliteration: 'Malik-ul-Mulk'),
    const _AsmaName(
        arabic: 'ذُو ٱلْجَلَالِ وَٱلْإِكْرَامِ',
        transliteration: 'Dhul-Jalali wal-Ikram'),
    const _AsmaName(arabic: 'ٱلْمُقْسِطُ', transliteration: 'Al-Muqsit'),
    const _AsmaName(arabic: 'ٱلْجَامِعُ', transliteration: 'Al-Jami’'),
    const _AsmaName(arabic: 'ٱلْغَنِيُّ', transliteration: 'Al-Ghaniyy'),
    const _AsmaName(arabic: 'ٱلْمُغْنِي', transliteration: 'Al-Mughni'),
    const _AsmaName(arabic: 'ٱلْمَانِعُ', transliteration: 'Al-Mani’'),
    const _AsmaName(arabic: 'ٱلضَّارُّ', transliteration: 'Ad-Darr'),
    const _AsmaName(arabic: 'ٱلنَّافِعُ', transliteration: 'An-Nafi’'),
    const _AsmaName(arabic: 'ٱلنُّورُ', transliteration: 'An-Nur'),
    const _AsmaName(arabic: 'ٱلْهَادِي', transliteration: 'Al-Hadi'),
    const _AsmaName(arabic: 'ٱلْبَدِيعُ', transliteration: 'Al-Badi’'),
    const _AsmaName(arabic: 'ٱلْبَاقِي', transliteration: 'Al-Baqi'),
    const _AsmaName(arabic: 'ٱلْوَارِثُ', transliteration: 'Al-Warith'),
    const _AsmaName(arabic: 'ٱلرَّشِيدُ', transliteration: 'Ar-Rashid'),
    const _AsmaName(arabic: 'ٱلصَّبُورُ', transliteration: 'As-Sabur'),
  ];

  static List<MoreEntryContent> get asmaUlHusnaEntries {
    return _asmaNames
        .asMap()
        .entries
        .map(
          (MapEntry<int, _AsmaName> e) => MoreEntryContent(
            title: '${e.key + 1}',
            primaryText: e.value.arabic,
            secondaryText: e.value.transliteration,
          ),
        )
        .toList(growable: false);
  }

  static const List<MoreEntryContent> duasEntries = <MoreEntryContent>[
    MoreEntryContent(
      title: 'Upon waking up',
      primaryText:
          'الْحَمْدُ لِلّٰهِ الَّذِي أَحْيَانَا بَعْدَمَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ',
      secondaryText:
          'تمام تعریف اللہ کے لیے ہے جس نے ہمیں موت (نیند) کے بعد زندگی دی، اور اسی کی طرف لوٹنا ہے۔',
      reference: 'Sahih al-Bukhari, Sahih Muslim',
    ),
    MoreEntryContent(
      title: 'Before sleeping',
      primaryText: ' اللَّهُمَّ بِاسْمِكَ أَمُوتُ وَأَحْيَا',
      secondaryText:
          'اے اللہ! تیرے نام کے ساتھ میں سوتا ہوں اور تیرے نام کے ساتھ جاگتا ہوں۔',
      reference: 'Sahih al-Bukhari',
    ),
    MoreEntryContent(
      title: 'While lying on bed',
      primaryText:
          'بِاسْمِكَ رَبِّي وَضَعْتُ جَنْبِي وَبِكَ أَرْفَعُهُ، فَإِنْ أَمْسَكْتَ نَفْسِي فَارْحَمْهَا، وَإِنْ أَرْسَلْتَهَا فَاحْفَظْهَا بِمَا تَحْفَظُ بِهِ عِبَادَكَ الصَّالِحِينَ',
      secondaryText:
          'اے میرے رب! تیرے نام سے میں پہلو رکھتا ہوں اور تیرے نام سے اٹھتا ہوں۔ اگر تو میری جان روک لے تو اس پر رحم فرما، اور اگر واپس بھیجے تو اسے اپنے نیک بندوں کی طرح محفوظ رکھ۔',
      reference: 'Sahih al-Bukhari, Sahih Muslim',
    ),
    MoreEntryContent(
      title: 'Before entering washroom',
      primaryText:
          'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْخُبُثِ وَالْخَبَائِثِ',
      secondaryText:
          'اے اللہ! میں خبیث جنات (نر و مادہ) کے شر سے تیری پناہ مانگتا ہوں۔',
      reference: 'Sahih al-Bukhari, Sahih Muslim',
    ),
    MoreEntryContent(
      title: 'After leaving washroom',
      primaryText: 'غُفْرَانَكَ',
      secondaryText: 'اے اللہ! میں تیری بخشش چاہتا ہوں۔',
      reference: 'Abu Dawud, Jami at-Tirmidhi (Hasan)',
    ),
    MoreEntryContent(
      title: 'After ablution (wudu)',
      primaryText:
          'أَشْهَدُ أَنْ لَا إِلٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ',
      secondaryText:
          'میں گواہی دیتا ہوں کہ اللہ کے سوا کوئی معبود نہیں، وہ اکیلا ہے، اس کا کوئی شریک نہیں، اور محمد ﷺ اس کے بندے اور رسول ہیں۔',
      reference: 'Sahih Muslim',
    ),
    MoreEntryContent(
      title: 'When leaving home',
      primaryText:
          'بِسْمِ اللَّهِ، تَوَكَّلْتُ عَلَى اللَّهِ، وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ',
      secondaryText:
          'اللہ کے نام سے، میں نے اللہ پر بھروسہ کیا، اور طاقت و قوت صرف اللہ ہی سے ہے۔',
      reference: 'Abu Dawud, Jami at-Tirmidhi',
    ),
    MoreEntryContent(
      title: 'When entering home',
      primaryText:
          'بِسْمِ اللَّهِ وَلَجْنَا، وَبِسْمِ اللَّهِ خَرَجْنَا، وَعَلَى رَبِّنَا تَوَكَّلْنَا',
      secondaryText:
          'اللہ کے نام سے ہم داخل ہوئے، اللہ کے نام سے ہم نکلے، اور ہم نے اپنے رب پر بھروسہ کیا۔',
      reference: 'Abu Dawud',
    ),
    MoreEntryContent(
      title: 'When entering masjid',
      primaryText: 'اللَّهُمَّ افْتَحْ لِي أَبْوَابَ رَحْمَتِكَ',
      secondaryText: 'اے اللہ! میرے لیے اپنی رحمت کے دروازے کھول دے۔',
      reference: 'Sahih Muslim',
    ),
    MoreEntryContent(
      title: 'When leaving masjid',
      primaryText: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ مِنْ فَضْلِكَ',
      secondaryText: 'اے اللہ! میں تجھ سے تیرے فضل کا سوال کرتا ہوں۔',
      reference: 'Sahih Muslim',
    ),
    MoreEntryContent(
      title: 'After adhan',
      primaryText:
          'اللَّهُمَّ رَبَّ هَذِهِ الدَّعْوَةِ التَّامَّةِ وَالصَّلَاةِ الْقَائِمَةِ، آتِ مُحَمَّدًا الْوَسِيلَةَ وَالْفَضِيلَةَ، وَابْعَثْهُ مَقَامًا مَحْمُودًا الَّذِي وَعَدْتَهُ',
      secondaryText:
          'اے اللہ! اس کامل دعوت اور قائم ہونے والی نماز کے رب! محمد ﷺ کو وسیلہ اور فضیلت عطا فرما اور انہیں مقامِ محمود عطا فرما جس کا تو نے وعدہ کیا ہے۔',
      reference: 'Sahih al-Bukhari',
    ),
    MoreEntryContent(
      title: 'Before eating',
      primaryText: 'بِسْمِ اللَّهِ',
      secondaryText: 'اللہ کے نام سے (کھانا شروع کرتا ہوں)۔',
      reference: 'Sahih al-Bukhari',
    ),
    MoreEntryContent(
      title: 'If forgot at beginning of meal',
      primaryText: 'بِسْمِ اللَّهِ أَوَّلَهُ وَآخِرَهُ',
      secondaryText: 'اللہ کے نام سے، اس کے شروع میں بھی اور آخر میں بھی۔',
      reference: 'Abu Dawud, Jami at-Tirmidhi',
    ),
    MoreEntryContent(
      title: 'After eating (short)',
      primaryText:
          'الْحَمْدُ لِلّٰهِ الَّذِي أَطْعَمَنِي هَذَا وَرَزَقَنِيهِ مِنْ غَيْرِ حَوْلٍ مِنِّي وَلَا قُوَّةٍ',
      secondaryText:
          'تمام تعریف اللہ کے لیے ہے جس نے مجھے یہ کھانا کھلایا اور بغیر میری طاقت کے مجھے رزق دیا۔',
      reference: 'Abu Dawud, Jami at-Tirmidhi',
    ),
    MoreEntryContent(
      title: 'After eating (extended praise)',
      primaryText:
          'الْحَمْدُ لِلّٰهِ حَمْدًا كَثِيرًا طَيِّبًا مُبَارَكًا فِيهِ، غَيْرَ مَكْفِيٍّ وَلَا مُوَدَّعٍ وَلَا مُسْتَغْنًى عَنْهُ رَبَّنَا',
      secondaryText:
          'اللہ کے لیے بہت زیادہ، پاکیزہ اور بابرکت تعریف ہے؛ اے ہمارے رب! ہم تیرے رزق سے بے نیاز نہیں۔',
      reference: 'Sahih al-Bukhari',
    ),
    MoreEntryContent(
      title: 'When sneezing',
      primaryText: 'الْحَمْدُ لِلّٰهِ',
      secondaryText: 'تمام تعریف اللہ کے لیے ہے۔',
      reference: 'Sahih al-Bukhari, Sahih Muslim',
    ),
    MoreEntryContent(
      title: 'Reply to one who sneezed',
      primaryText: 'يَرْحَمُكَ اللَّهُ',
      secondaryText: 'اللہ تم پر رحم فرمائے۔',
      reference: 'Sahih al-Bukhari, Sahih Muslim',
    ),
    MoreEntryContent(
      title: 'Response after being prayed for (sneezing)',
      primaryText: 'يَهْدِيكُمُ اللَّهُ وَيُصْلِحُ بَالَكُمْ',
      secondaryText: 'اللہ تمہیں ہدایت دے اور تمہاری حالت درست فرمائے۔',
      reference: 'Sahih al-Bukhari',
    ),
    MoreEntryContent(
      title: 'When angry',
      primaryText: 'أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ',
      secondaryText: 'میں مردود شیطان سے اللہ کی پناہ مانگتا ہوں۔',
      reference: 'Sahih al-Bukhari, Sahih Muslim',
    ),
    MoreEntryContent(
      title: 'When feeling anxiety and sorrow',
      primaryText:
          'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ، وَالْعَجْزِ وَالْكَسَلِ، وَالْبُخْلِ وَالْجُبْنِ، وَضَلَعِ الدَّيْنِ وَغَلَبَةِ الرِّجَالِ',
      secondaryText:
          'اے اللہ! میں غم اور فکر، عاجزی اور سستی، بخل اور بزدلی، قرض کے بوجھ اور لوگوں کے غلبے سے تیری پناہ مانگتا ہوں۔',
      reference: 'Sahih al-Bukhari',
    ),
    MoreEntryContent(
      title: 'Dua of distress',
      primaryText:
          'لَا إِلٰهَ إِلَّا اللَّهُ الْعَظِيمُ الْحَلِيمُ، لَا إِلٰهَ إِلَّا اللَّهُ رَبُّ الْعَرْشِ الْعَظِيمِ، لَا إِلٰهَ إِلَّا اللَّهُ رَبُّ السَّمَاوَاتِ وَرَبُّ الْأَرْضِ وَرَبُّ الْعَرْشِ الْكَرِيمِ',
      secondaryText:
          'اللہ کے سوا کوئی معبود نہیں، وہ عظمت والا اور بردبار ہے؛ اللہ کے سوا کوئی معبود نہیں، وہ عرشِ عظیم کا رب ہے؛ اللہ کے سوا کوئی معبود نہیں، وہ آسمانوں، زمین اور عرشِ کریم کا رب ہے۔',
      reference: 'Sahih al-Bukhari, Sahih Muslim',
    ),
    MoreEntryContent(
      title: 'Seeking forgiveness (short)',
      primaryText: 'أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ',
      secondaryText:
          'میں اللہ سے بخشش مانگتا ہوں اور اسی کی طرف توبہ کرتا ہوں۔',
      reference: 'Sahih al-Bukhari, Sahih Muslim',
    ),
    MoreEntryContent(
      title: 'Sayyid al-Istighfar',
      primaryText:
          'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلٰهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي، فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ',
      secondaryText:
          'اے اللہ! تو میرا رب ہے، تیرے سوا کوئی معبود نہیں۔ تو نے مجھے پیدا کیا اور میں تیرا بندہ ہوں... پس مجھے بخش دے، کیونکہ تیرے سوا کوئی گناہوں کو معاف نہیں کرتا۔',
      reference: 'Sahih al-Bukhari',
    ),
    MoreEntryContent(
      title: 'Before travel (on ride)',
      primaryText:
          'سُبْحَانَ الَّذِي سَخَّرَ لَنَا هٰذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ وَإِنَّا إِلَىٰ رَبِّنَا لَمُنْقَلِبُونَ',
      secondaryText:
          'پاک ہے وہ ذات جس نے اس سواری کو ہمارے لیے مسخر کیا، ورنہ ہم اسے قابو نہ کرسکتے تھے، اور بے شک ہمیں اپنے رب کی طرف لوٹنا ہے۔',
      reference: 'Sahih Muslim',
    ),
    MoreEntryContent(
      title: 'During travel',
      primaryText:
          'اللَّهُمَّ إِنَّا نَسْأَلُكَ فِي سَفَرِنَا هٰذَا الْبِرَّ وَالتَّقْوَى، وَمِنَ الْعَمَلِ مَا تَرْضَى، اللَّهُمَّ هَوِّنْ عَلَيْنَا سَفَرَنَا هٰذَا وَاطْوِ عَنَّا بُعْدَهُ، اللَّهُمَّ أَنْتَ الصَّاحِبُ فِي السَّفَرِ وَالْخَلِيفَةُ فِي الْأَهْلِ، اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ وَعْثَاءِ السَّفَرِ وَكَآبَةِ الْمَنْظَرِ وَسُوءِ الْمُنْقَلَبِ فِي الْمَالِ وَالْأَهْلِ',
      secondaryText:
          'اے اللہ! ہم اپنے اس سفر میں نیکی، تقویٰ اور وہ عمل مانگتے ہیں جس سے تو راضی ہو۔ اے اللہ! ہمارا سفر آسان فرما، اس کی دوری لپیٹ دے، اور مال و اہل میں بُرے انجام سے بچا۔',
      reference: 'Sahih Muslim',
    ),
    MoreEntryContent(
      title: 'After returning from travel',
      primaryText: 'آيِبُونَ تَائِبُونَ عَابِدُونَ لِرَبِّنَا حَامِدُونَ',
      secondaryText:
          'ہم واپس آنے والے، توبہ کرنے والے، عبادت گزار اور اپنے رب کی حمد کرنے والے ہیں۔',
      reference: 'Sahih al-Bukhari, Sahih Muslim',
    ),
    MoreEntryContent(
      title: 'Upon breaking fast',
      primaryText:
          'ذَهَبَ الظَّمَأُ وَابْتَلَّتِ الْعُرُوقُ وَثَبَتَ الْأَجْرُ إِنْ شَاءَ اللَّهُ',
      secondaryText:
          'پیاس ختم ہوگئی، رگیں تر ہوگئیں اور ان شاء اللہ اجر ثابت ہوگیا۔',
      reference: 'Abu Dawud (Hasan)',
    ),
    MoreEntryContent(
      title: 'When feeling pain in body',
      primaryText:
          'أَعُوذُ بِعِزَّةِ اللَّهِ وَقُدْرَتِهِ مِنْ شَرِّ مَا أَجِدُ وَأُحَاذِرُ',
      secondaryText:
          'میں اللہ کی عزت اور قدرت کی پناہ مانگتا ہوں اس تکلیف سے جو میں محسوس کرتا ہوں اور جس سے ڈرتا ہوں۔',
      reference: 'Sahih Muslim',
    ),
    MoreEntryContent(
      title: 'Morning and evening protection',
      primaryText:
          'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
      secondaryText:
          'اللہ کے نام کے ساتھ جس کے نام کے ہوتے ہوئے زمین و آسمان میں کوئی چیز نقصان نہیں پہنچا سکتی، اور وہ خوب سننے والا، خوب جاننے والا ہے۔',
      reference: 'Abu Dawud, Jami at-Tirmidhi (Hasan Sahih)',
    ),
    MoreEntryContent(
      title: 'When stopping at a place',
      primaryText:
          'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
      secondaryText:
          'میں اللہ کے کامل کلمات کے ذریعے اس کی مخلوق کے شر سے پناہ مانگتا ہوں۔',
      reference: 'Sahih Muslim',
    ),
    MoreEntryContent(
      title: 'For help in worship',
      primaryText:
          'اللَّهُمَّ أَعِنِّي عَلَى ذِكْرِكَ وَشُكْرِكَ وَحُسْنِ عِبَادَتِكَ',
      secondaryText:
          'اے اللہ! اپنے ذکر، اپنی شکر گزاری اور اچھی عبادت پر میری مدد فرما۔',
      reference: 'Abu Dawud, Sunan an-Nasai',
    ),
    MoreEntryContent(
      title: 'For beneficial knowledge',
      primaryText: 'رَبِّ زِدْنِي عِلْمًا',
      secondaryText: 'اے میرے رب! میرے علم میں اضافہ فرما۔',
      reference: 'Qur’an 20:114',
    ),
    MoreEntryContent(
      title: 'For parents',
      primaryText: 'رَبِّ ارْحَمْهُمَا كَمَا رَبَّيَانِي صَغِيرًا',
      secondaryText:
          'اے میرے رب! میرے والدین پر رحم فرما جیسے انہوں نے بچپن میں میری پرورش کی۔',
      reference: 'Qur’an 17:24',
    ),
    MoreEntryContent(
      title: 'Comprehensive good in both worlds',
      primaryText:
          'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ',
      secondaryText:
          'اے ہمارے رب! ہمیں دنیا میں بھلائی دے، آخرت میں بھی بھلائی دے اور ہمیں آگ کے عذاب سے بچا۔',
      reference: 'Qur’an 2:201',
    ),
    MoreEntryContent(
      title: 'For steadfast faith',
      primaryText:
          'رَبَّنَا لَا تُزِغْ قُلُوبَنَا بَعْدَ إِذْ هَدَيْتَنَا وَهَبْ لَنَا مِنْ لَدُنْكَ رَحْمَةً إِنَّكَ أَنْتَ الْوَهَّابُ',
      secondaryText:
          'اے ہمارے رب! ہدایت کے بعد ہمارے دل ٹیڑھے نہ کر، اور اپنے پاس سے ہمیں رحمت عطا فرما، بے شک تو ہی بہت عطا کرنے والا ہے۔',
      reference: 'Qur’an 3:8',
    ),
    MoreEntryContent(
      title: 'For relief from distress',
      primaryText:
          'لَا إِلٰهَ إِلَّا أَنْتَ سُبْحَانَكَ إِنِّي كُنْتُ مِنَ الظَّالِمِينَ',
      secondaryText:
          'تیرے سوا کوئی معبود نہیں، تو پاک ہے، بے شک میں ہی ظالموں میں سے تھا۔',
      reference: 'Qur’an 21:87',
    ),
    MoreEntryContent(
      title: 'For ease in speech and tasks',
      primaryText:
          'رَبِّ اشْرَحْ لِي صَدْرِي وَيَسِّرْ لِي أَمْرِي وَاحْلُلْ عُقْدَةً مِنْ لِسَانِي يَفْقَهُوا قَوْلِي',
      secondaryText:
          'اے میرے رب! میرا سینہ کھول دے، میرا کام آسان کر دے، میری زبان کی گرہ کھول دے تاکہ لوگ میری بات سمجھ سکیں۔',
      reference: 'Qur’an 20:25-28',
    ),
    MoreEntryContent(
      title: 'For forgiveness and mercy',
      primaryText:
          'رَبَّنَا ظَلَمْنَا أَنْفُسَنَا وَإِنْ لَمْ تَغْفِرْ لَنَا وَتَرْحَمْنَا لَنَكُونَنَّ مِنَ الْخَاسِرِينَ',
      secondaryText:
          'اے ہمارے رب! ہم نے اپنے آپ پر ظلم کیا، اگر تو ہمیں نہ بخشے اور ہم پر رحم نہ کرے تو ہم یقیناً خسارہ پانے والوں میں سے ہوجائیں گے۔',
      reference: 'Qur’an 7:23',
    ),
    MoreEntryContent(
      title: 'For protection from burden and sins',
      primaryText:
          'رَبَّنَا لَا تُؤَاخِذْنَا إِنْ نَسِينَا أَوْ أَخْطَأْنَا، رَبَّنَا وَلَا تَحْمِلْ عَلَيْنَا إِصْرًا كَمَا حَمَلْتَهُ عَلَى الَّذِينَ مِنْ قَبْلِنَا، رَبَّنَا وَلَا تُحَمِّلْنَا مَا لَا طَاقَةَ لَنَا بِهِ، وَاعْفُ عَنَّا وَاغْفِرْ لَنَا وَارْحَمْنَا، أَنْتَ مَوْلَانَا فَانْصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ',
      secondaryText:
          'اے ہمارے رب! اگر ہم بھول جائیں یا خطا کریں تو ہمیں نہ پکڑ۔ ہم پر وہ بوجھ نہ ڈال جیسے پہلے لوگوں پر ڈالا۔ ہمیں وہ ذمہ داری نہ دے جس کی طاقت ہم میں نہ ہو۔ ہمیں معاف فرما، بخش دے اور رحم فرما۔',
      reference: 'Qur’an 2:286',
    ),
    MoreEntryContent(
      title: 'For righteous offspring',
      primaryText:
          'رَبِّ هَبْ لِي مِنْ لَدُنْكَ ذُرِّيَّةً طَيِّبَةً إِنَّكَ سَمِيعُ الدُّعَاءِ',
      secondaryText:
          'اے میرے رب! مجھے اپنی طرف سے پاکیزہ اولاد عطا فرما، بے شک تو دعا سننے والا ہے۔',
      reference: 'Qur’an 3:38',
    ),
    MoreEntryContent(
      title: 'For provision and need',
      primaryText: 'رَبِّ إِنِّي لِمَا أَنْزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيرٌ',
      secondaryText:
          'اے میرے رب! جو بھلائی تو مجھ پر نازل کرے، میں اس کا محتاج ہوں۔',
      reference: 'Qur’an 28:24',
    ),
    MoreEntryContent(
      title: 'For family righteousness',
      primaryText:
          'رَبَّنَا هَبْ لَنَا مِنْ أَزْوَاجِنَا وَذُرِّيَّاتِنَا قُرَّةَ أَعْيُنٍ وَاجْعَلْنَا لِلْمُتَّقِينَ إِمَامًا',
      secondaryText:
          'اے ہمارے رب! ہمیں ہماری بیویوں اور اولاد سے آنکھوں کی ٹھنڈک عطا فرما، اور ہمیں متقیوں کا پیشوا بنا۔',
      reference: 'Qur’an 25:74',
    ),
  ];

  static const List<MoreEntryContent> kalimaEntries = <MoreEntryContent>[
    MoreEntryContent(
      title: '1) Kalima Tayyibah',
      primaryText: 'لَا إِلٰهَ إِلَّا ٱللّٰهُ مُحَمَّدٌ رَسُولُ ٱللّٰهِ',
      secondaryText:
          'اللہ کے سوا کوئی عبادت کے لائق نہیں، محمد ﷺ اللہ کے رسول ہیں۔',
    ),
    MoreEntryContent(
      title: '2) Kalima Shahadat',
      primaryText:
          'أَشْهَدُ أَنْ لَا إِلٰهَ إِلَّا ٱللّٰهُ وَحْدَهُ لَا شَرِيكَ لَهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ',
      secondaryText:
          'میں گواہی دیتا ہوں کہ اللہ کے سوا کوئی معبود نہیں، وہ اکیلا ہے، اس کا کوئی شریک نہیں، اور میں گواہی دیتا ہوں کہ محمد ﷺ اس کے بندے اور رسول ہیں۔',
    ),
    MoreEntryContent(
      title: '3) Kalima Tamjeed',
      primaryText:
          'سُبْحَانَ ٱللّٰهِ وَٱلْحَمْدُ لِلّٰهِ وَلَا إِلٰهَ إِلَّا ٱللّٰهُ وَٱللّٰهُ أَكْبَرُ وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِٱللّٰهِ ٱلْعَلِيِّ ٱلْعَظِيمِ',
      secondaryText:
          'اللہ پاک ہے، سب تعریف اللہ کے لیے ہے، اللہ کے سوا کوئی معبود نہیں، اللہ سب سے بڑا ہے، اور نیکی کی طاقت اور برائی سے بچنے کی قوت صرف اللہ بلند و عظیم سے ہے۔',
    ),
    MoreEntryContent(
      title: '4) Kalima Tauheed',
      primaryText:
          'لَا إِلٰهَ إِلَّا ٱللّٰهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ ٱلْمُلْكُ وَلَهُ ٱلْحَمْدُ، يُحْيِي وَيُمِيتُ وَهُوَ حَيٌّ لَا يَمُوتُ أَبَدًا أَبَدًا، ذُو ٱلْجَلَالِ وَٱلْإِكْرَامِ، بِيَدِهِ ٱلْخَيْرُ وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ',
      secondaryText:
          'اللہ کے سوا کوئی معبود نہیں، وہ اکیلا ہے، اس کا کوئی شریک نہیں۔ بادشاہی اور تعریف اسی کے لیے ہے۔ وہ زندہ کرتا ہے اور موت دیتا ہے، وہ ہمیشہ زندہ ہے، اسے کبھی موت نہیں۔ وہ صاحبِ جلال و اکرام ہے، بھلائی اسی کے ہاتھ میں ہے اور وہ ہر چیز پر قادر ہے۔',
    ),
    MoreEntryContent(
      title: '5) Kalima Istighfar',
      primaryText:
          'أَسْتَغْفِرُ ٱللّٰهَ رَبِّي مِنْ كُلِّ ذَنْبٍ أَذْنَبْتُهُ عَمْدًا أَوْ خَطَأً سِرًّا أَوْ عَلَانِيَةً وَأَتُوبُ إِلَيْهِ مِنَ ٱلذَّنْبِ ٱلَّذِي أَعْلَمُ وَمِنَ ٱلذَّنْبِ ٱلَّذِي لَا أَعْلَمُ، إِنَّكَ أَنْتَ عَلَّامُ ٱلْغُيُوبِ وَسَتَّارُ ٱلْعُيُوبِ وَغَفَّارُ ٱلذُّنُوبِ، وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِٱللّٰهِ ٱلْعَلِيِّ ٱلْعَظِيمِ',
      secondaryText:
          'میں اللہ اپنے رب سے ہر گناہ کی بخشش مانگتا ہوں جو میں نے جان بوجھ کر یا غلطی سے، چھپ کر یا ظاہر کیا، اور میں اس کی طرف توبہ کرتا ہوں۔ بے شک تو غیب جاننے والا، عیب چھپانے والا اور گناہ بخشنے والا ہے۔',
    ),
    MoreEntryContent(
      title: '6) Kalima Radd-e-Kufr',
      primaryText:
          'ٱللّٰهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ أَنْ أُشْرِكَ بِكَ شَيْئًا وَأَنَا أَعْلَمُ بِهِ، وَأَسْتَغْفِرُكَ لِمَا لَا أَعْلَمُ بِهِ، تُبْتُ عَنْهُ وَتَبَرَّأْتُ مِنَ ٱلْكُفْرِ وَٱلشِّرْكِ وَٱلْكِذْبِ وَٱلْغِيبَةِ وَٱلْبِدْعَةِ وَٱلنَّمِيمَةِ وَٱلْفَوَاحِشِ وَٱلْبُهْتَانِ وَٱلْمَعَاصِي كُلِّهَا، وَأَسْلَمْتُ وَأَقُولُ لَا إِلٰهَ إِلَّا ٱللّٰهُ مُحَمَّدٌ رَسُولُ ٱللّٰهِ',
      secondaryText:
          'اے اللہ! میں تیری پناہ مانگتا ہوں کہ میں جانتے بوجھتے تیرے ساتھ کسی کو شریک کروں، اور جو میں نہ جانتا ہوں اس پر تجھ سے معافی مانگتا ہوں۔ میں کفر و شرک اور تمام برائیوں سے توبہ کرتا ہوں اور اقرار کرتا ہوں کہ اللہ کے سوا کوئی معبود نہیں، محمد ﷺ اللہ کے رسول ہیں۔',
    ),
  ];

  static const List<MoreEntryContent> pillarsEntries = <MoreEntryContent>[
    MoreEntryContent(
      title: 'Shahada',
      primaryText:
          'The testimony that Allah alone is worthy of worship and Muhammad ﷺ is His Messenger; the foundation of Islamic faith.',
      icon: Icons.verified_rounded,
    ),
    MoreEntryContent(
      title: 'Salah',
      primaryText:
          'The five daily prayers that connect a Muslim to Allah through worship, discipline, and remembrance.',
      icon: Icons.access_time_filled_rounded,
    ),
    MoreEntryContent(
      title: 'Zakat',
      primaryText:
          'Obligatory charity on eligible wealth to purify one’s earnings and support people in need.',
      icon: Icons.volunteer_activism_rounded,
    ),
    MoreEntryContent(
      title: 'Sawm',
      primaryText:
          'Fasting in Ramadan from dawn to sunset to build taqwa, gratitude, and self-control.',
      icon: Icons.nights_stay_rounded,
    ),
    MoreEntryContent(
      title: 'Hajj',
      primaryText:
          'Pilgrimage to Makkah once in a lifetime for those able, symbolizing unity and submission to Allah.',
      icon: Icons.flight_takeoff_rounded,
    ),
  ];

  static const List<MoreEntryContent> hadithEntries = <MoreEntryContent>[
    MoreEntryContent(
      title: 'Intentions',
      primaryText: 'Actions are judged by intentions.',
      reference: 'Sahih al-Bukhari 1; Sahih Muslim 1907a',
    ),
    MoreEntryContent(
      title: 'Speak good or remain silent',
      primaryText:
          'Whoever believes in Allah and the Last Day should speak good or keep silent.',
      reference: 'Sahih al-Bukhari 6018; Sahih Muslim 47a',
    ),
    MoreEntryContent(
      title: 'Learn and teach Quran',
      primaryText:
          'The best among you are those who learn the Quran and teach it.',
      reference: 'Sahih al-Bukhari 5027',
    ),
    MoreEntryContent(
      title: 'Stranger in this world',
      primaryText: 'Be in this world as if you were a stranger or a traveler.',
      reference: 'Sahih al-Bukhari 6416',
    ),
    MoreEntryContent(
      title: 'Gentleness',
      primaryText: 'Allah is kind and He loves kindness.',
      reference: 'Sahih Muslim 2593',
    ),
  ];

  static const List<MoreEntryContent> reminderEntries = <MoreEntryContent>[
    MoreEntryContent(
      title: 'Daily sincerity',
      primaryText: 'Begin each day with a sincere intention to please Allah.',
      reference: 'Practical Islamic reminder',
    ),
    MoreEntryContent(
      title: 'Steady prayer',
      primaryText: 'Guard your prayers even on difficult days.',
      reference: 'Practical Islamic reminder',
    ),
    MoreEntryContent(
      title: 'Mercy in character',
      primaryText: 'Let mercy shape your words and decisions.',
      reference: 'Practical Islamic reminder',
    ),
    MoreEntryContent(
      title: 'Patience in trials',
      primaryText: 'Patience is not passive; it is active trust in Allah.',
      reference: 'Practical Islamic reminder',
    ),
    MoreEntryContent(
      title: 'Repent often',
      primaryText: 'Turn back to Allah often with humility and hope.',
      reference: 'Practical Islamic reminder',
    ),
    MoreEntryContent(
      title: 'Gratitude practice',
      primaryText: 'Write down one blessing each day and thank Allah for it.',
      reference: 'Practical Islamic reminder',
    ),
  ];

  static final List<MoreSectionContent> sections = <MoreSectionContent>[
    MoreSectionContent(
      id: 'asma',
      title: '99 Names of Allah',
      subtitle: 'Reflect on Asma ul Husna with Arabic and transliteration.',
      icon: Icons.stars_rounded,
      layout: MoreSectionLayout.names,
      entries: asmaUlHusnaEntries,
      bottomNote: 'Source: أسماء الله الحسنى (Authentic Islamic references)',
    ),
    const MoreSectionContent(
      id: 'duas',
      title: 'Duas',
      subtitle: 'Daily authentic duas with Arabic and Urdu translation.',
      icon: Icons.pan_tool_alt_rounded,
      layout: MoreSectionLayout.arabicWithUrdu,
      entries: duasEntries,
      bottomNote:
          'References policy: Only Qur’an and widely accepted authenticated daily adhkar (Sahih/Hasan reports).',
    ),
    const MoreSectionContent(
      id: 'kalima',
      title: 'Kalima',
      subtitle: 'All 6 Kalimas in Arabic with Urdu translation.',
      icon: Icons.flag_circle_rounded,
      layout: MoreSectionLayout.arabicWithUrdu,
      entries: kalimaEntries,
      bottomNote:
          'Note: The first two Kalimas are the foundational testimonies of faith.',
    ),
    const MoreSectionContent(
      id: 'pillars',
      title: 'Pillars of Islam',
      subtitle: 'The five core foundations of Islamic practice.',
      icon: Icons.account_balance_rounded,
      layout: MoreSectionLayout.info,
      entries: pillarsEntries,
    ),
    const MoreSectionContent(
      id: 'hadith',
      title: 'Hadith',
      subtitle: 'Authentic hadith with references for clarity.',
      icon: Icons.auto_stories_rounded,
      layout: MoreSectionLayout.info,
      entries: hadithEntries,
    ),
    const MoreSectionContent(
      id: 'reminders',
      title: 'Islamic Reminders',
      subtitle: 'Practical spiritual reminders for daily living.',
      icon: Icons.lightbulb_outline_rounded,
      layout: MoreSectionLayout.info,
      entries: reminderEntries,
    ),
  ];
}

class _AsmaName {
  const _AsmaName({
    required this.arabic,
    required this.transliteration,
  });

  final String arabic;
  final String transliteration;
}
