import 'dart:isolate';

import 'package:flutter/services.dart';

import '../../core/constants/app_constants.dart';
import '../models/quote.dart';

class QuoteRepository {
  QuoteRepository(this._bundle);

  final AssetBundle _bundle;

  static const int _minimumQuoteCount = 320;

  static const List<String> _reminderCategories = <String>[
    'Faith',
    'Patience',
    'Gratitude',
    'Prayer',
    'Hope',
    'Mercy',
    'Forgiveness',
    'Life',
    'Character',
    'Reflection',
  ];

  static const List<String> _reflectionStems = <String>[
    'Begin your day with sincere remembrance of Allah',
    'When your heart feels heavy, pause and make a quiet dua',
    'A small act of patience can protect your heart from regret',
    'Choose gentle words when emotions run high',
    'Renew your intention before every important task',
    'Guard your prayer even on your busiest days',
    'True strength appears when you forgive for the sake of Allah',
    'Gratitude grows when you notice the blessings you already have',
    'Speak truth with wisdom and compassion',
    'Take your worries to Allah before taking them to people',
    'Consistency in small good deeds reshapes the soul',
    'A calm response can end a conflict before it begins',
    'Remember that every delay has divine wisdom behind it',
    'Your private sincerity is more valuable than public praise',
    'A believer shines through good character in ordinary moments',
    'Let the Quran be your first source of comfort',
    'Hope in Allah should stay alive even during long trials',
    'Protect your tongue from words that darken the heart',
    'Repentance is a door that remains open while life remains',
    'Choose trust in Allah over constant anxiety',
    'Every hardship can become a path toward spiritual growth',
    'Kindness to family is among the most blessed daily deeds',
    'Silence can be worship when it prevents harm',
    'Ask Allah for guidance before making major decisions',
    'A humble heart receives wisdom more easily',
    'Do not underestimate one sincere sajdah in the night',
    'Purify your intention before seeking worldly success',
    'Good assumptions about Allah bring peace to the soul',
    'Feed your heart with remembrance before feeding your ego',
    'Every test carries an invitation to come closer to Allah',
    'Control anger with patience and prayer',
    'Being grateful in ease prepares you for patience in hardship',
    'Character is revealed by how you treat people who cannot benefit you',
    'A believer keeps moving forward even after setbacks',
    'Return to istighfar whenever your chest feels tight',
    'Your calm trust in Allah is itself an act of worship',
    'Choose principled decisions even when shortcuts look easier',
    'Mercy in your dealings brings mercy into your life',
    'Protect your morning and evening with remembrance',
    'Serve others quietly and leave your reward with Allah',
  ];

  static const List<String> _reflectionStemsUr = <String>[
    'اپنے دن کا آغاز اللہ کے مخلصانہ ذکر سے کریں',
    'جب دل بوجھل ہو تو رک جائیں اور خاموشی سے دعا کریں',
    'صبر کا ایک چھوٹا سا عمل آپ کے دل کو ندامت سے بچا سکتا ہے',
    'جب جذبات تیز ہوں تو نرم الفاظ اختیار کریں',
    'ہر اہم کام سے پہلے اپنی نیت کو تازہ کریں',
    'اپنے سب سے مصروف دنوں میں بھی نماز کی حفاظت کریں',
    'حقیقی طاقت اُس وقت ظاہر ہوتی ہے جب آپ اللہ کی خاطر معاف کرتے ہیں',
    'شکر گزاری اُس وقت بڑھتی ہے جب آپ اپنی موجود نعمتوں کو پہچانتے ہیں',
    'سچ کو حکمت اور شفقت کے ساتھ بیان کریں',
    'اپنی پریشانیاں لوگوں سے پہلے اللہ کے حضور پیش کریں',
    'چھوٹے نیک اعمال میں پابندی روح کو سنوار دیتی ہے',
    'پرسکون جواب جھگڑے کو شروع ہونے سے پہلے ختم کر سکتا ہے',
    'یاد رکھیں کہ ہر تاخیر کے پیچھے اللہ کی حکمت ہوتی ہے',
    'آپ کا پوشیدہ اخلاص عوامی تعریف سے زیادہ قیمتی ہے',
    'مومن عام لمحات میں بھی اچھے اخلاق سے نمایاں ہوتا ہے',
    'اپنے سکون کا پہلا ذریعہ قرآن کو بنائیں',
    'طویل آزمائشوں میں بھی اللہ سے امید زندہ رکھیں',
    'اپنی زبان کو اُن الفاظ سے بچائیں جو دل کو تاریک کر دیں',
    'توبہ وہ دروازہ ہے جو زندگی باقی رہنے تک کھلا رہتا ہے',
    'مسلسل بے چینی کے بجائے اللہ پر بھروسہ اختیار کریں',
    'ہر مشکل روحانی ترقی کا راستہ بن سکتی ہے',
    'خاندان کے ساتھ نرمی روزمرہ کے بابرکت اعمال میں سے ہے',
    'جب خاموشی نقصان سے بچائے تو وہ بھی عبادت بن جاتی ہے',
    'بڑے فیصلوں سے پہلے اللہ سے رہنمائی مانگیں',
    'عاجز دل حکمت کو زیادہ آسانی سے قبول کرتا ہے',
    'رات کے ایک مخلص سجدے کو کبھی معمولی نہ سمجھیں',
    'دنیاوی کامیابی کی کوشش سے پہلے اپنی نیت پاک کریں',
    'اللہ کے بارے میں حسنِ ظن روح کو سکون دیتا ہے',
    'اپنے نفس کو خوش کرنے سے پہلے دل کو ذکرِ الٰہی سے غذا دیں',
    'ہر آزمائش میں اللہ کے قریب ہونے کی دعوت ہوتی ہے',
    'غصے کو صبر اور نماز سے قابو میں رکھیں',
    'آسانی میں شکر ادا کرنا سختی میں صبر کے لیے تیار کرتا ہے',
    'اخلاق اس سے ظاہر ہوتے ہیں کہ آپ اُن لوگوں سے کیسا سلوک کرتے ہیں جو آپ کو فائدہ نہیں دے سکتے',
    'مومن ناکامیوں کے بعد بھی آگے بڑھتا رہتا ہے',
    'جب بھی سینہ تنگ محسوس ہو تو استغفار کی طرف لوٹ آئیں',
    'اللہ پر آپ کا پُرسکون بھروسہ خود ایک عبادت ہے',
    'راستے آسان لگیں تب بھی اصولی فیصلے اختیار کریں',
    'معاملات میں رحمت آپ کی زندگی میں رحمت لے آتی ہے',
    'اپنی صبح و شام کو ذکرِ الٰہی سے محفوظ رکھیں',
    'دوسروں کی خاموشی سے خدمت کریں اور اجر اللہ پر چھوڑ دیں',
  ];

  static const List<String> _reflectionClosings = <String>[
    ', and trust that no sincere effort is ever lost.',
    ', then take one honest step toward what is right.',
    ', and let your character reflect your faith.',
    ', because Allah sees both your struggle and your sincerity.',
    ', and ask Allah to place barakah in your next action.',
    ', while remembering that ease comes after hardship.',
    ', and choose what pleases Allah over what pleases the ego.',
    ', so your heart stays anchored in hope and gratitude.',
  ];

  static const List<String> _reflectionClosingsUr = <String>[
    '، اور یقین رکھیں کہ کوئی بھی مخلص کوشش ضائع نہیں ہوتی۔',
    '، پھر حق کی طرف ایک سچا قدم اٹھائیں۔',
    '، اور اپنے کردار کو اپنے ایمان کا آئینہ بنائیں۔',
    '، کیونکہ اللہ آپ کی جدوجہد اور اخلاص دونوں کو دیکھتا ہے۔',
    '، اور اپنے اگلے عمل میں برکت کے لیے اللہ سے دعا کریں۔',
    '، اور یاد رکھیں کہ سختی کے بعد آسانی آتی ہے۔',
    '، اور وہی اختیار کریں جو اللہ کو پسند ہو نہ کہ نفس کو۔',
    '، تاکہ آپ کا دل امید اور شکر پر قائم رہے۔',
  ];

  Future<List<Quote>> loadQuotes() async {
    final String rawJson = await _bundle.loadString('assets/quotes.json');
    // Parse in a background isolate for smoother first paint on larger datasets.
    final List<Quote> quotes = await Isolate.run<List<Quote>>(() {
      final List<Quote> parsed = Quote.listFromJson(rawJson);
      final List<Quote> expanded = _expandWithGeneralReminders(parsed);
      expanded.sort((Quote a, Quote b) => a.id.compareTo(b.id));
      return expanded;
    });
    return quotes;
  }

  static List<Quote> _expandWithGeneralReminders(List<Quote> base) {
    if (base.length >= _minimumQuoteCount) {
      return base;
    }

    final int requiredExtra = _minimumQuoteCount - base.length;
    final int maxId =
        base.fold<int>(0, (int prev, Quote q) => q.id > prev ? q.id : prev);
    final List<Quote> generated = _buildGeneratedReminders(
      startId: maxId + 1,
      count: requiredExtra,
    );

    return <Quote>[...base, ...generated];
  }

  static List<Quote> _buildGeneratedReminders({
    required int startId,
    required int count,
  }) {
    final List<Quote> generated = <Quote>[];
    int nextId = startId;

    for (int stemIndex = 0; stemIndex < _reflectionStems.length; stemIndex++) {
      final String stemEn = _reflectionStems[stemIndex];
      final String stemUr = _reflectionStemsUr[stemIndex];

      for (int closingIndex = 0;
          closingIndex < _reflectionClosings.length;
          closingIndex++) {
        if (generated.length >= count) {
          break;
        }

        final String closingEn = _reflectionClosings[closingIndex];
        final String closingUr = _reflectionClosingsUr[closingIndex];

        final String category =
            _reminderCategories[generated.length % _reminderCategories.length];
        final String textEn = '$stemEn$closingEn';
        final String textUr = '$stemUr$closingUr';
        generated.add(
          Quote(
            id: nextId,
            textEn: textEn,
            textUr: textUr,
            source: 'General Islamic Reminder',
            category: category,
          ),
        );
        nextId += 1;
      }

      if (generated.length >= count) {
        break;
      }
    }

    // Fallback in case template counts are changed in the future.
    while (generated.length < count) {
      final int i = generated.length;
      final String category =
          AppConstants.categories[i % AppConstants.categories.length];
      generated.add(
        Quote(
          id: nextId,
          textEn:
              'Hold firmly to sincere faith, good character, and trust in Allah in every season of life.',
          textUr:
              'زندگی کے ہر مرحلے میں اخلاصِ ایمان، اچھے اخلاق اور اللہ پر بھروسے کو مضبوطی سے تھامے رکھیں۔',
          source: 'General Islamic Reminder',
          category: category,
        ),
      );
      nextId += 1;
    }

    return generated;
  }
}
