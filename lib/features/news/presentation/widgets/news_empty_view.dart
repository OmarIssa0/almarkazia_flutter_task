import 'package:flutter/material.dart';

class NewsEmptyView extends StatelessWidget {
  const NewsEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(color: colorScheme.secondaryContainer, shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Icon(Icons.article_outlined, size: 42, color: colorScheme.onSecondaryContainer),
                ),
              ),
              const SizedBox(height: 18),
              Text('No articles found', style: textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(
                'Pull to refresh for the latest headlines.',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
