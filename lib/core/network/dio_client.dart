import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _baseUrl = 'https://newsapi.org/v2';
const _requestTimeout = Duration(seconds: 15);
const newsApiKey = String.fromEnvironment('NEWS_API_KEY');

final dioClientProvider = Provider<Dio>((ref) {
  if (newsApiKey.isEmpty) {
    throw StateError('NEWS_API_KEY is missing. Pass it with --dart-define=NEWS_API_KEY.');
  }

  final dio = Dio(BaseOptions(baseUrl: _baseUrl, connectTimeout: _requestTimeout, receiveTimeout: _requestTimeout));

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        options.queryParameters = <String, dynamic>{...options.queryParameters, 'apiKey': newsApiKey};

        handler.next(options);
      },
    ),
  );

  return dio;
});
