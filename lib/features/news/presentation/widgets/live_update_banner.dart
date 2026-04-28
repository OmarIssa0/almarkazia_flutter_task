import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

class LiveUpdateBanner extends StatelessWidget {
  const LiveUpdateBanner({required this.article, required this.onTap, required this.onDismiss, super.key});

  final Article article;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final date = DateFormat.jm().format(article.publishedAt);

    return Dismissible(
      key: ValueKey<String>('${article.title}-${article.publishedAt.toIso8601String()}'),
      onDismissed: (_) => onDismiss(),
      background: const _DismissBackground(alignment: Alignment.centerLeft),
      secondaryBackground: const _DismissBackground(alignment: Alignment.centerRight),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [BoxShadow(color: colorScheme.primary.withValues(alpha: 0.18), blurRadius: 24, offset: const Offset(0, 10))],
          ),
          child: Material(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(22),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(color: colorScheme.onPrimaryContainer.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(Icons.bolt_rounded, color: colorScheme.onPrimaryContainer),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Live Update',
                            style: textTheme.labelMedium?.copyWith(color: colorScheme.onPrimaryContainer, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            article.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleSmall?.copyWith(color: colorScheme.onPrimaryContainer),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${article.source} • $date',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodySmall?.copyWith(color: colorScheme.onPrimaryContainer),
                          ),
                        ],
                      ),
                    ),
                    IconButton(onPressed: onDismiss, icon: const Icon(Icons.close_rounded), color: colorScheme.onPrimaryContainer),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DismissBackground extends StatelessWidget {
  const _DismissBackground({required this.alignment});

  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
      child: DecoratedBox(
        decoration: BoxDecoration(color: colorScheme.errorContainer, borderRadius: BorderRadius.circular(22)),
        child: Align(
          alignment: alignment,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(Icons.close_rounded, color: colorScheme.onErrorContainer),
          ),
        ),
      ),
    );
  }
}
