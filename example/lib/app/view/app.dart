import 'package:flutter_claude/app/action/app_action.dart';
import 'package:flutter_claude/app/router/app_router.dart';
import 'package:flutter_claude/app/viewmodel/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  static final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(
      appViewModelProvider.select((s) => s.themeMode),
    );

    ref.listen(
      appViewModelProvider.select((s) => s.toast),
      (_, toast) {
        if (toast == null) return;
        _messengerKey.currentState
          ?..clearSnackBars()
          ..showSnackBar(SnackBar(content: Text(toast.message)));
        ref
            .read(appViewModelProvider.notifier)
            .dispatch(const AppAction.toastDismissed());
      },
    );

    return MaterialApp.router(
      title: 'FlutterSample',
      scaffoldMessengerKey: _messengerKey,
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
