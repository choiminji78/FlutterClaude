import 'package:flutter/material.dart';
import 'package:flutter_claude/app/router/app_routes.dart';
import 'package:flutter_claude/app/viewmodel/app_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appVm = ref.read(appViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Claude Example')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton.icon(
              onPressed: () => appVm.push(AppRoutes.contact),
              icon: const Icon(Icons.storage),
              label: const Text('Storage'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => appVm.push(AppRoutes.post),
              icon: const Icon(Icons.cloud_upload),
              label: const Text('Network'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
