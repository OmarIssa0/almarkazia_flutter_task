import 'package:news_app/features/news/data/api/news_api_client.dart';
import 'package:news_app/features/news/data/models/article_model.dart';

abstract interface class NewsRemoteDataSource {
  Future<List<ArticleModel>> getTopHeadlines();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  const NewsRemoteDataSourceImpl(this._client);

  final NewsApiClient _client;

  @override
  Future<List<ArticleModel>> getTopHeadlines() async {
    final response = await _client.getTopHeadlines();
    return response.articles;
  }
}
