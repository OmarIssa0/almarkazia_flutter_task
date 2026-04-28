import 'package:flutter/material.dart';
import 'package:news_app/features/news/presentation/widgets/image_fallback.dart';

class DetailHeroImage extends StatelessWidget {
  const DetailHeroImage({required this.imageUrl, required this.heroTag, super.key});

  final String imageUrl;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(26);

    final image = ClipRRect(
      borderRadius: radius,
      child: AspectRatio(
        aspectRatio: 16 / 10,
        child: imageUrl.isEmpty
            ? const ImageFallback(size: 54)
            : Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(imageUrl, fit: BoxFit.cover, errorBuilder: (_, _, _) => const ImageFallback(size: 54)),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [colorScheme.scrim.withValues(alpha: 0), colorScheme.scrim.withValues(alpha: 0.36)]),
                    ),
                  ),
                ],
              ),
      ),
    );

    if (imageUrl.isEmpty) {
      return image;
    }

    return Hero(tag: heroTag, child: image);
  }
}
