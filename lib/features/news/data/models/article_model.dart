import 'package:news_app/features/news/domain/entities/article.dart';

class ArticleModel {
  const ArticleModel({required this.title, required this.description, required this.imageUrl, required this.source, required this.url, required this.publishedAt});

  final String title;
  final String description;
  final String imageUrl;
  final String source;
  final String url;
  final DateTime publishedAt;

  factory ArticleModel.fromNewsApiJson(Map<String, dynamic> json) {
    final source = json['source'];
    final description = _readString(json['description'], fallback: _readString(json['content']));

    return ArticleModel(
      title: _readString(json['title'], fallback: 'Untitled article'),
      description: description,
      imageUrl: _readString(json['urlToImage']),
      source: source is Map<String, dynamic> ? _readString(source['name'], fallback: 'Unknown source') : 'Unknown source',
      url: _readString(json['url']),
      publishedAt: _readIsoDate(json['publishedAt']),
    );
  }

  static ArticleModel? fromBinanceTradeJson(Map<String, dynamic> json) {
    final price = _readString(json['p']);
    final symbol = _readString(json['s']);

    if (price.isEmpty || symbol.isEmpty) {
      return null;
    }

    final asset = _baseAsset(symbol);

    return ArticleModel(title: 'Live $asset market update: \$$price', description: 'Live market update', imageUrl: '', source: 'Binance', url: '', publishedAt: DateTime.now());
  }

  static ArticleModel? fromBinanceTradeMessage(Object? json) {
    if (json is! Map<String, dynamic>) {
      return null;
    }

    return ArticleModel.fromBinanceTradeJson(json);
  }

  Article toEntity() {
    return Article(title: title, description: description, imageUrl: imageUrl, source: source, url: url, publishedAt: publishedAt);
  }

  static String _readString(dynamic value, {String fallback = ''}) {
    if (value is! String) {
      return fallback;
    }

    final trimmed = value.trim();
    return trimmed.isEmpty ? fallback : trimmed;
  }

  static DateTime _readIsoDate(dynamic value) {
    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.now();
    }

    return DateTime.now();
  }

  static String _baseAsset(String symbol) {
    if (symbol.endsWith('USDT') && symbol.length > 4) {
      return symbol.substring(0, symbol.length - 4);
    }

    return symbol.isEmpty ? 'BTC' : symbol;
  }
}
