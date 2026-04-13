import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../providers/onboarding_provider.dart';
import 'main_shell_screen.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  final List<_OnboardingData> _pages = const <_OnboardingData>[
    _OnboardingData(
      title: 'Welcome to Isalamic Quotes & Reminders',
      description:
          'A spiritually calming space for Islamic reminders, reflection, and daily motivation.',
      illustrationAsset: 'assets/illustrations/peace.svg',
    ),
    _OnboardingData(
      title: 'Read, save, and revisit',
      description:
          'Swipe through elegant quote cards, save favorites, and revisit them whenever your heart needs calm.',
      illustrationAsset: 'assets/illustrations/bookmark.svg',
    ),
    _OnboardingData(
      title: 'Grow with daily consistency',
      description:
          'Build a peaceful habit with mindful reminders and beautiful, distraction-free reading.',
      illustrationAsset: 'assets/illustrations/peace.svg',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    if (_index < _pages.length - 1) {
      await _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
      return;
    }

    await ref.read(onboardingProvider.notifier).completeOnboarding();
    if (!mounted) {
      return;
    }

    await Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const MainShellScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final bool isLastPage = _index == _pages.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(12, 10, 6, 10),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 4),
                    Text(
                      'Islamic Quotes',
                      style: theme.textTheme.headlineMedium
                          ?.copyWith(fontSize: 34),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: _continue,
                      child: Text(isLastPage ? 'Start' : 'Skip'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (int value) => setState(() => _index = value),
                  itemBuilder: (BuildContext context, int index) {
                    final _OnboardingData page = _pages[index];
                    return LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(4, 18, 4, 18),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minHeight: constraints.maxHeight - 36),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 210,
                                  height: 210,
                                  padding: const EdgeInsets.all(22),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(42),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: <Color>[
                                        scheme.primaryContainer
                                            .withValues(alpha: 0.85),
                                        scheme.tertiaryContainer
                                            .withValues(alpha: 0.55),
                                      ],
                                    ),
                                    border: Border.all(
                                      color: scheme.outlineVariant
                                          .withValues(alpha: 0.35),
                                    ),
                                  ),
                                  child: SvgPicture.asset(
                                    page.illustrationAsset,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Text(
                                  page.title,
                                  textAlign: TextAlign.center,
                                  style:
                                      theme.textTheme.headlineMedium?.copyWith(
                                    fontSize: 38,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  page.description,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Tip: Long-press any quote card for quick actions.',
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                  _pages.length,
                  (int i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: _index == i ? 26 : 10,
                    height: 10.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: _index == i
                          ? theme.colorScheme.primary
                          : theme.colorScheme.outline.withValues(alpha: 0.35),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _continue,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child:
                        Text(isLastPage ? 'Enter Islamic Quotes' : 'Continue'),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () async {
                    await ref
                        .read(onboardingProvider.notifier)
                        .completeOnboarding();
                    if (!context.mounted) {
                      return;
                    }
                    await Navigator.of(context).pushReplacement(
                      MaterialPageRoute<void>(
                          builder: (_) => const MainShellScreen()),
                    );
                  },
                  child: const Text('Skip onboarding'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingData {
  const _OnboardingData({
    required this.title,
    required this.description,
    required this.illustrationAsset,
  });

  final String title;
  final String description;
  final String illustrationAsset;
}
