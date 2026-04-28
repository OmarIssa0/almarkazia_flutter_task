import 'package:news_app/core/error/result.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

abstract interface class NewsRepository {
  Future<Result<List<Article>>> getHeadlines();
}
