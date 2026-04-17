import 'dart:async';
import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin BaseKeepAliveViewModel<S, A> on Notifier<S> {
  final Queue<A> _queue = Queue<A>();
  bool _isProcessing = false;

  @override
  S build() => buildInitialState();

  S buildInitialState();

  S reduce(S state, A action);

  Future<void> handleEffect(A action);

  void dispatch(A action) {
    _queue.add(action);
    unawaited(_drain());
  }

  Future<void> _drain() async {
    if (_isProcessing) return;
    _isProcessing = true;
    while (_queue.isNotEmpty) {
      final action = _queue.removeFirst();
      state = reduce(state, action);
      try {
        await handleEffect(action);
      } catch (_) {
        // Effect 예외가 다음 액션 처리를 막지 않도록 격리
      }
    }
    _isProcessing = false;
  }
}
