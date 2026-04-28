import 'package:dio/dio.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/error/result.dart';
import 'package:news_app/features/news/data/datasources/news_remote_datasource.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  const NewsRepositoryImpl(this._remoteDataSource);

  final NewsRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<Article>>> getHeadlines() async {
    try {
      final articleModels = await _remoteDataSource.getTopHeadlines();
      final articles = articleModels.map((article) => article.toEntity()).toList(growable: false);

      return Success<List<Article>>(articles);
    } on DioException catch (error) {
      return FailureResult<List<Article>>(_mapDioException(error));
    } on FormatException catch (error) {
      return FailureResult<List<Article>>(ParsingFailure(_readMessage(error.message, fallback: 'Unable to parse news data.')));
    } on Exception catch (error) {
      return FailureResult<List<Article>>(ServerFailure(_readMessage(_readExceptionMessage(error), fallback: 'News service returned an invalid response.')));
    } catch (_) {
      return const FailureResult<List<Article>>(UnknownFailure('Unable to load headlines.'));
    }
  }

  Failure _mapDioException(DioException error) {
    final statusCode = error.response?.statusCode?.toString();
    final message = _readDioMessage(error);

    return switch (error.type) {
      DioExceptionType.connectionTimeout || DioExceptionType.receiveTimeout || DioExceptionType.sendTimeout || DioExceptionType.connectionError => NetworkFailure(message, code: statusCode),
      DioExceptionType.badResponse => ServerFailure(message, code: statusCode),
      DioExceptionType.badCertificate || DioExceptionType.cancel || DioExceptionType.unknown => UnknownFailure(message, code: statusCode),
    };
  }

  String _readDioMessage(DioException error) {
    return _readMessage(error.message, fallback: 'Unable to load headlines. Please try again.');
  }

  String _readMessage(String? message, {required String fallback}) {
    if (message == null) {
      return fallback;
    }

    final trimmed = message.trim();
    return trimmed.isEmpty ? fallback : trimmed;
  }

  String _readExceptionMessage(Exception error) {
    final message = error.toString();
    const exceptionPrefix = 'Exception: ';

    if (message.startsWith(exceptionPrefix)) {
      return message.substring(exceptionPrefix.length);
    }

    return message;
  }
}
