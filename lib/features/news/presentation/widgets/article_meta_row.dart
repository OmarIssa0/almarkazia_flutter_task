import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/features/news/presentation/widgets/article_source_chip.dart';

class ArticleMetaRow extends StatelessWidget {
  const ArticleMetaRow({required this.source, required this.publishedAt, this.compact = false, super.key});

  final String source;
  final DateTime publishedAt;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final formattedDate = compact ? DateFormat.MMMd().format(publishedAt) : DateFormat.yMMMMd().add_jm().format(publishedAt);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ArticleSourceChip(source: source, compact: compact),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.schedule_rounded, size: compact ? 13 : 15, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: 5),
            Text(
              formattedDate,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: (compact ? textTheme.bodySmall : textTheme.labelMedium)?.copyWith(color: colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ],
    );
  }
}
