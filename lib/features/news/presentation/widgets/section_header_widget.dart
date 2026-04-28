import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
      child: Row(
        children: [
          Text('Top Headlines', style: textTheme.titleMedium),
          const Spacer(),
          Text('Today', style: textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}
