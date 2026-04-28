import 'package:flutter/material.dart';

class ImageFallback extends StatelessWidget {
  const ImageFallback({this.size = 24, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(Icons.image_outlined, color: colorScheme.onSurfaceVariant, size: size),
      ),
    );
  }
}
