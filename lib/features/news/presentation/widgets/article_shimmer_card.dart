import 'package:flutter/material.dart';
import 'package:news_app/features/news/presentation/widgets/shimmer_block.dart';
import 'package:shimmer/shimmer.dart';

class ArticleShimmerCard extends StatelessWidget {
  const ArticleShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Shimmer.fromColors(
            baseColor: colorScheme.surfaceContainerHighest,
            highlightColor: colorScheme.surface,
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBlock(width: 114, height: 96),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [ShimmerBlock(width: 86, height: 24), SizedBox(width: 8), ShimmerBlock(width: 58, height: 14)]),
                      SizedBox(height: 14),
                      ShimmerBlock(height: 16),
                      SizedBox(height: 8),
                      ShimmerBlock(width: 220, height: 16),
                      SizedBox(height: 8),
                      ShimmerBlock(width: 150, height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
