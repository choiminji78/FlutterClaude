import 'package:flutter/material.dart';
import 'package:flutter_claude/feature/post_create/action/post_create_action.dart';
import 'package:flutter_claude/feature/post_create/viewmodel/post_create_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostCreatePage extends ConsumerWidget {
  const PostCreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(postCreateViewModelProvider.notifier);

    ref.listen(postCreateViewModelProvider, (prev, next) {
      if (next.createdPost != null && prev?.createdPost == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('게시글 생성됨 (id: ${next.createdPost!.id})')),
        );
      }
      if (next.error != null && prev?.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              next.error!.when(
                network: (msg) => '네트워크 오류: $msg',
                server: (code, msg) => '서버 오류 $code: $msg',
                unauthorized: (msg) => '인증 오류: $msg',
                forbidden: (msg) => '접근 거부: $msg',
                notFound: (msg) => '찾을 수 없음: $msg',
                timeout: (msg) => '시간 초과: $msg',
                unknown: (msg) => '오류: $msg',
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    final state = ref.watch(postCreateViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('게시글 작성')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: '제목',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) =>
                  vm.dispatch(PostCreateAction.titleChanged(v)),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: '내용',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              onChanged: (v) =>
                  vm.dispatch(PostCreateAction.bodyChanged(v)),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: state.isLoading ? null : vm.submit,
              child: state.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('게시글 생성'),
            ),
            if (state.createdPost != null) ...[
              const SizedBox(height: 32),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '생성된 게시글',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Divider(),
                      Text('ID: ${state.createdPost!.id}'),
                      const SizedBox(height: 4),
                      Text('제목: ${state.createdPost!.title}'),
                      const SizedBox(height: 4),
                      Text('내용: ${state.createdPost!.body}'),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
