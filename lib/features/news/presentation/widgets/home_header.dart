import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({required this.isLiveAvailable, required this.isLiveConnecting, super.key});

  final bool isLiveAvailable;
  final bool isLiveConnecting;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final statusText = isLiveConnecting
        ? 'Connecting'
        : isLiveAvailable
        ? 'Live'
        : 'Offline';
    final statusColor = isLiveConnecting
        ? colorScheme.secondary
        : isLiveAvailable
        ? colorScheme.primary
        : colorScheme.error;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: colorScheme.outlineVariant),
          boxShadow: [BoxShadow(color: colorScheme.shadow.withValues(alpha: 0.06), blurRadius: 28, offset: const Offset(0, 12))],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('News Reader', style: textTheme.headlineMedium),
                    const SizedBox(height: 8),
                    Text('Curated headlines with real-time market updates.', style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              DecoratedBox(
                decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(999)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
                        child: const SizedBox(width: 8, height: 8),
                      ),
                      const SizedBox(width: 7),
                      Text(statusText, style: textTheme.labelMedium?.copyWith(color: colorScheme.onSurface)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
