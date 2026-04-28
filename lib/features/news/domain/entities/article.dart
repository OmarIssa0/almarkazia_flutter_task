import 'package:flutter/foundation.dart';

@immutable
class Article {
  const Article({required this.title, required this.description, required this.imageUrl, required this.source, required this.url, required this.publishedAt});

  final String title;
  final String description;
  final String imageUrl;
  final String source;
  final String url;
  final DateTime publishedAt;

  String get stableId => url.isNotEmpty ? url : title;

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Article && other.title == title && other.description == description && other.imageUrl == imageUrl && other.source == source && other.url == url && other.publishedAt == publishedAt;
  }

  @override
  int get hashCode {
    return Object.hash(title, description, imageUrl, source, url, publishedAt);
  }
}
