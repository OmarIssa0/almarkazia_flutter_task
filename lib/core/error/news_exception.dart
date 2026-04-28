final class NewsException implements Exception {
  const NewsException(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}
