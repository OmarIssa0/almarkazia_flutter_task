import 'package:dio/dio.dart';
import 'package:news_app/features/news/data/models/news_api_response.dart';

abstract interface class NewsApiClient {
  Future<NewsApiResponse> getTopHeadlines();
}

class DioNewsApiClient implements NewsApiClient {
  const DioNewsApiClient(this._dio);

  final Dio _dio;

  @override
  Future<NewsApiResponse> getTopHeadlines() async {
    final response = await _dio.get('/top-headlines', queryParameters: const {'country': 'us'});

    return NewsApiResponse.fromJson(response.data);
  }
}
