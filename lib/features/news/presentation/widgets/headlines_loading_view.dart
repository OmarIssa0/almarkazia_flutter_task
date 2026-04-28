import 'package:flutter/material.dart';
import 'package:news_app/features/news/presentation/widgets/article_shimmer_card.dart';

class HeadlinesLoadingView extends StatelessWidget {
  const HeadlinesLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [SizedBox(height: 8), ArticleShimmerCard(), ArticleShimmerCard(), ArticleShimmerCard(), ArticleShimmerCard(), ArticleShimmerCard(), ArticleShimmerCard()]);
  }
}
