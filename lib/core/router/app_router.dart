import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/screens/detail_screen.dart';
import 'package:news_app/features/news/presentation/screens/home_screen.dart';

final appRouterProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    routes: <RouteBase>[
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/article',
        builder: (context, state) {
          final extra = state.extra;

          if (extra is! Article) {
            return const HomeScreen();
          }

          return DetailScreen(article: extra);
        },
      ),
    ],
  ),
);
