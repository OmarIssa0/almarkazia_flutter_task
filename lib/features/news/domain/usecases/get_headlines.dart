import 'package:news_app/core/error/result.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

class GetHeadlines {
  const GetHeadlines(this._repository);

  final NewsRepository _repository;

  Future<Result<List<Article>>> call() {
    return _repository.getHeadlines();
  }
}
