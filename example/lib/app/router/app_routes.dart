import 'package:flutter_claude/feature/contact_input/view/contact_input_page.dart';
import 'package:flutter_claude/feature/home/view/home_page.dart';
import 'package:flutter_claude/feature/post_create/view/post_create_page.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const home = '/';
  static const contact = '/contact';
  static const post = '/post';

  static final routes = <RouteBase>[
    GoRoute(
      path: home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: contact,
      builder: (context, state) => const ContactInputPage(),
    ),
    GoRoute(
      path: post,
      builder: (context, state) => const PostCreatePage(),
    ),
  ];
}
