import 'package:flutter/material.dart';

class DetailContentSection extends StatelessWidget {
  const DetailContentSection({required this.description, super.key});

  final String description;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final content = description.trim().isEmpty ? 'No description available.' : description.trim();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: [BoxShadow(color: colorScheme.shadow.withValues(alpha: 0.05), blurRadius: 22, offset: const Offset(0, 10))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Text(content, style: textTheme.bodyLarge),
      ),
    );
  }
}
