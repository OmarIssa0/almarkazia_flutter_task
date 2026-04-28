import 'dart:async';
import 'dart:convert';

import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class NewsSocketDataSource {
  Stream<Article> streamNews();

  Future<void> dispose();
}

class NewsSocketDataSourceImpl implements NewsSocketDataSource {
  static final Uri _uri = Uri.parse('wss://stream.binance.com:9443/ws/btcusdt@trade');

  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _subscription;
  Stream<Article>? _stream;
  StreamController<Article>? _controller;

  @override
  Stream<Article> streamNews() {
    final activeStream = _stream;
    if (activeStream != null) {
      return activeStream;
    }

    final controller = StreamController<Article>.broadcast(
      onCancel: () {
        unawaited(dispose());
      },
    );
    _controller = controller;
    _stream = controller.stream;

    final channel = WebSocketChannel.connect(_uri);

    _channel = channel;

    channel.ready.catchError((Object error, StackTrace stackTrace) {
      if (!controller.isClosed) {
        controller.addError(error, stackTrace);
      }
    });

    _subscription = channel.stream.listen(
      (message) {
        _handleMessage(message, controller);
      },
      onError: (Object error, StackTrace stackTrace) {
        if (!controller.isClosed) {
          controller.addError(error, stackTrace);
        }
      },
      onDone: () {
        if (!controller.isClosed) {
          controller.close();
        }
      },
    );

    return _stream!;
  }

  void _handleMessage(dynamic message, StreamController<Article> controller) {
    if (message is! String || controller.isClosed) {
      return;
    }

    final dynamic decoded;
    try {
      decoded = jsonDecode(message);
    } on FormatException {
      return;
    }

    final article = ArticleModel.fromBinanceTradeMessage(decoded);
    if (article != null && !controller.isClosed) {
      controller.add(article.toEntity());
    }
  }

  @override
  Future<void> dispose() async {
    final subscription = _subscription;
    final channel = _channel;
    final controller = _controller;

    _subscription = null;
    _channel = null;
    _stream = null;
    _controller = null;

    await subscription?.cancel();
    await channel?.sink.close();

    if (controller != null && !controller.isClosed) {
      await controller.close();
    }
  }
}
