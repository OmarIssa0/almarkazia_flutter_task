import 'package:news_app/features/news/data/models/article_model.dart';

class NewsApiResponse {
  const NewsApiResponse({required this.articles});

  final List<ArticleModel> articles;

  factory NewsApiResponse.fromJson(Object? json) {
    if (json is! Map<String, dynamic>) {
      throw const FormatException('Invalid response format');
    }

    if (json['status'] == 'error') {
      throw Exception(_readMessage(json));
    }

    final rawArticles = json['articles'];
    if (rawArticles is! List) {
      throw const FormatException('Invalid articles field');
    }

    return NewsApiResponse(articles: rawArticles.map(_parseArticle).toList(growable: false));
  }

  static ArticleModel _parseArticle(Object? item) {
    if (item is! Map<String, dynamic>) {
      throw const FormatException('Invalid article item');
    }

    return ArticleModel.fromNewsApiJson(item);
  }

  static String _readMessage(Map<String, dynamic> json) {
    final message = json['message'];

    if (message is String && message.trim().isNotEmpty) {
      return message.trim();
    }

    return 'NewsAPI request failed.';
  }
}
