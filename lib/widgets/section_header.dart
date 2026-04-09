import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    this.leadingIcon = Icons.menu_rounded,
    this.onLeadingTap,
    this.trailing,
    super.key,
  });

  final String title;
  final IconData leadingIcon;
  final VoidCallback? onLeadingTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(26)),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Color(0xFF1A8F52), Color(0xFF33C06C)],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: -28,
              bottom: -30,
              child: Icon(
                Icons.mosque_rounded,
                size: 180,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            Positioned(
              left: 22,
              top: 16,
              child: Icon(
                Icons.auto_awesome_rounded,
                size: 58,
                color: Colors.white.withValues(alpha: 0.10),
              ),
            ),
            SafeArea(
              bottom: false,
              child: SizedBox(
                height: 86,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: <Widget>[
                      _HeaderIconButton(
                        icon: leadingIcon,
                        onTap: onLeadingTap,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            title,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: Colors.white,
                              fontSize: 38,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 44,
                        height: 44,
                        child: trailing ?? const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Widget iconWidget = Icon(icon, color: Colors.white, size: 24);

    return SizedBox(
      width: 44,
      height: 44,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.16),
          shape: BoxShape.circle,
        ),
        child: onTap == null
            ? Center(child: iconWidget)
            : IconButton(
                onPressed: onTap,
                icon: iconWidget,
                splashRadius: 22,
              ),
      ),
    );
  }
}
