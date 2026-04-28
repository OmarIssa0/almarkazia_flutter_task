import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/news/di/providers.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/notifiers/headlines_notifier.dart';
import 'package:news_app/features/news/presentation/widgets/article_card.dart';
import 'package:news_app/features/news/presentation/widgets/headlines_loading_view.dart';
import 'package:news_app/features/news/presentation/widgets/home_header.dart';
import 'package:news_app/features/news/presentation/widgets/live_update_banner.dart';
import 'package:news_app/features/news/presentation/widgets/live_updates_unavailable_banner.dart';
import 'package:news_app/features/news/presentation/widgets/news_empty_view.dart';
import 'package:news_app/features/news/presentation/widgets/news_error_view.dart';
import 'package:news_app/features/news/presentation/widgets/section_header_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<Article>>(liveNewsProvider, (previous, next) {
      next.whenData((article) {
        ref.read(liveArticleBannerProvider.notifier).show(article);
      });
    });

    final headlines = ref.watch(headlinesProvider);
    final liveArticle = ref.watch(liveArticleBannerProvider);
    final isLiveUnavailable = ref.watch(liveNewsProvider.select((value) => value.hasError));
    final isLiveConnecting = ref.watch(liveNewsProvider.select((value) => value.isLoading));

    return Scaffold(
      body: SafeArea(
        child: headlines.when(
          data: (articles) => RefreshIndicator(
            onRefresh: () => _refreshHeadlines(ref),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 20),
              children: [
                HomeHeader(isLiveAvailable: !isLiveUnavailable, isLiveConnecting: isLiveConnecting),
                if (isLiveUnavailable) const LiveUpdatesUnavailableBanner(),
                if (liveArticle != null)
                  LiveUpdateBanner(
                    article: liveArticle,
                    onTap: () => _openArticle(context, liveArticle),
                    onDismiss: () {
                      ref.read(liveArticleBannerProvider.notifier).dismiss();
                    },
                  ),
                const SectionHeader(),
                if (articles.isEmpty) const NewsEmptyView() else for (final article in articles) ArticleCard(article: article, onTap: () => _openArticle(context, article)),
              ],
            ),
          ),
          loading: () => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 20),
            children: [
              HomeHeader(isLiveAvailable: !isLiveUnavailable, isLiveConnecting: isLiveConnecting),
              const HeadlinesLoadingView(),
            ],
          ),
          error: (error, stackTrace) => RefreshIndicator(
            onRefresh: () => _refreshHeadlines(ref),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 20),
              children: [
                HomeHeader(isLiveAvailable: !isLiveUnavailable, isLiveConnecting: isLiveConnecting),
                NewsErrorView(message: error.toString(), onRetry: () => _refreshHeadlines(ref)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refreshHeadlines(WidgetRef ref) {
    return ref.read(headlinesProvider.notifier).refresh();
  }

  void _openArticle(BuildContext context, Article article) {
    context.push('/article', extra: article);
  }
}
