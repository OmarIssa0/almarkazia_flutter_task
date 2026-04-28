import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/error/news_exception.dart';
import 'package:news_app/features/news/di/providers.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

final headlinesProvider = AsyncNotifierProvider<HeadlinesNotifier, List<Article>>(HeadlinesNotifier.new);

class HeadlinesNotifier extends AsyncNotifier<List<Article>> {
  @override
  Future<List<Article>> build() {
    return _fetchHeadlines();
  }

  Future<void> refresh() async {
    state = const AsyncLoading<List<Article>>();
    state = await AsyncValue.guard(_fetchHeadlines);
  }

  Future<List<Article>> _fetchHeadlines() async {
    final result = await ref.read(getHeadlinesProvider)();

    return result.when(success: (articles) => articles, failure: (failure) => throw NewsException(failure.message));
  }
}
