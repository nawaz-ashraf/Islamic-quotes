import 'package:flutter/material.dart';

class QuoteActionsSheet extends StatelessWidget {
  const QuoteActionsSheet({
    required this.isFavorite,
    required this.onFavorite,
    required this.onCopy,
    required this.onShare,
    super.key,
  });

  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onCopy;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
            child: Text(
              'Quick Actions',
              style: theme.textTheme.titleMedium,
            ),
          ),
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            leading: Icon(isFavorite
                ? Icons.favorite_rounded
                : Icons.favorite_border_rounded),
            title: Text(
                isFavorite ? 'Remove from favorites' : 'Save to favorites'),
            onTap: () {
              Navigator.of(context).pop();
              onFavorite();
            },
          ),
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            leading: const Icon(Icons.copy_rounded),
            title: const Text('Copy quote'),
            onTap: () {
              Navigator.of(context).pop();
              onCopy();
            },
          ),
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            leading: const Icon(Icons.share_rounded),
            title: const Text('Share quote'),
            onTap: () {
              Navigator.of(context).pop();
              onShare();
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
