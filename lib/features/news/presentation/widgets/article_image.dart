import 'package:flutter/material.dart';
import 'package:news_app/features/news/presentation/widgets/image_fallback.dart';

class ArticleImage extends StatelessWidget {
  const ArticleImage({required this.imageUrl, required this.heroTag, required this.width, required this.height, super.key});

  final String imageUrl;
  final String heroTag;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(18);

    final image = ClipRRect(
      borderRadius: radius,
      child: SizedBox(
        width: width,
        height: height,
        child: imageUrl.isEmpty ? const ImageFallback(size: 30) : Image.network(imageUrl, fit: BoxFit.cover, errorBuilder: (_, _, _) => const ImageFallback(size: 30)),
      ),
    );

    if (imageUrl.isEmpty) {
      return image;
    }

    return Hero(tag: heroTag, child: image);
  }
}
