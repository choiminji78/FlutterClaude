import 'package:flutter_claude/app/router/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    routes: AppRoutes.routes,
    initialLocation: AppRoutes.home,
  );
}
