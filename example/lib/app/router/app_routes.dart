import 'package:flutter_claude/feature/contact_input/view/contact_input_page.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const home = '/';

  static final routes = <RouteBase>[
    GoRoute(
      path: home,
      builder: (context, state) => const ContactInputPage(),
    ),
  ];
}
