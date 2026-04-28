import 'package:flutter/material.dart';

class ShimmerBlock extends StatelessWidget {
  const ShimmerBlock({required this.height, super.key, this.width});

  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(14)),
    );
  }
}
