import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/network/dio_client.dart';
import 'package:news_app/features/news/data/api/news_api_client.dart';
import 'package:news_app/features/news/data/datasources/news_remote_datasource.dart';
import 'package:news_app/features/news/data/datasources/news_socket_datasource.dart';
import 'package:news_app/features/news/data/repositories/news_repository_impl.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_app/features/news/domain/usecases/get_headlines.dart';

final newsApiClientProvider = Provider<NewsApiClient>((ref) {
  final dio = ref.watch(dioClientProvider);
  return DioNewsApiClient(dio);
});

final newsRemoteDataSourceProvider = Provider<NewsRemoteDataSource>((ref) {
  final client = ref.watch(newsApiClientProvider);
  return NewsRemoteDataSourceImpl(client);
});

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  final remoteDataSource = ref.watch(newsRemoteDataSourceProvider);
  return NewsRepositoryImpl(remoteDataSource);
});

final getHeadlinesProvider = Provider<GetHeadlines>((ref) {
  final repository = ref.watch(newsRepositoryProvider);
  return GetHeadlines(repository);
});

final newsSocketDataSourceProvider = Provider.autoDispose<NewsSocketDataSource>((ref) {
  final dataSource = NewsSocketDataSourceImpl();

  ref.onDispose(() {
    unawaited(dataSource.dispose());
  });

  return dataSource;
});

final liveNewsProvider = StreamProvider.autoDispose<Article>((ref) {
  final dataSource = ref.watch(newsSocketDataSourceProvider);
  return dataSource.streamNews();
});

final liveArticleBannerProvider = NotifierProvider.autoDispose<LiveArticleBannerNotifier, Article?>(LiveArticleBannerNotifier.new);

class LiveArticleBannerNotifier extends Notifier<Article?> {
  @override
  Article? build() {
    return null;
  }

  void show(Article article) {
    state = article;
  }

  void dismiss() {
    state = null;
  }
}
