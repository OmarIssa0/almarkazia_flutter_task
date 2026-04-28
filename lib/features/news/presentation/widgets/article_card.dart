import 'package:flutter/material.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/widgets/article_image.dart';
import 'package:news_app/features/news/presentation/widgets/article_meta_row.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({required this.article, required this.onTap, super.key});

  final Article article;
  final VoidCallback onTap;

  String get _heroTag => article.stableId;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final radius = BorderRadius.circular(22);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: radius,
          border: Border.all(color: colorScheme.outlineVariant),
          boxShadow: [BoxShadow(color: colorScheme.shadow.withValues(alpha: 0.07), blurRadius: 24, offset: const Offset(0, 10))],
        ),
        child: Material(
          color: colorScheme.surface,
          borderRadius: radius,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ArticleImage(imageUrl: article.imageUrl, heroTag: _heroTag, width: 114, height: 96),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ArticleMetaRow(source: article.source, publishedAt: article.publishedAt, compact: true),
                        const SizedBox(height: 10),
                        Text(article.title, maxLines: 3, overflow: TextOverflow.ellipsis, style: textTheme.titleMedium),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Icon(Icons.chevron_right_rounded, color: colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
