import 'package:flutter/material.dart';

class ArticleSourceChip extends StatelessWidget {
  const ArticleSourceChip({required this.source, this.compact = false, super.key});

  final String source;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final maxWidth = MediaQuery.sizeOf(context).width * (compact ? 0.32 : 0.72);

    return DecoratedBox(
      decoration: BoxDecoration(color: colorScheme.primaryContainer, borderRadius: BorderRadius.circular(compact ? 10 : 12)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 10, vertical: compact ? 4 : 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.public_rounded, size: compact ? 12 : 14, color: colorScheme.onPrimaryContainer),
            const SizedBox(width: 5),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Text(
                source,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: (compact ? textTheme.labelSmall : textTheme.labelMedium)?.copyWith(color: colorScheme.onPrimaryContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
