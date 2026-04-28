import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/utils/open_article.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/widgets/article_meta_row.dart';
import 'package:news_app/features/news/presentation/widgets/detail_content_section.dart';
import 'package:news_app/features/news/presentation/widgets/detail_hero_image.dart';
import 'package:news_app/features/news/presentation/widgets/primary_action_button.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({required this.article, super.key});

  final Article article;

  String get _heroTag => article.stableId;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new), onPressed: () => context.pop()),
              title: const Text('Article'),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailHeroImage(imageUrl: article.imageUrl, heroTag: _heroTag),
                    const SizedBox(height: 22),
                    ArticleMetaRow(source: article.source, publishedAt: article.publishedAt),
                    const SizedBox(height: 16),
                    Text(article.title, style: textTheme.headlineSmall),
                    const SizedBox(height: 18),
                    DetailContentSection(description: article.description),
                    const SizedBox(height: 28),
                    PrimaryActionButton(label: 'Open Article', icon: Icons.open_in_new, isEnabled: article.url.isNotEmpty, onPressed: () => openArticle(context, article.url)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
