import 'dart:async';

import 'package:flutter_claude/core/viewmodel/base_view_model.dart';
import 'package:flutter_claude/feature/contact_input/action/contact_input_action.dart';
import 'package:flutter_claude/feature/contact_input/effect/contact_input_effect.dart';
import 'package:flutter_claude/feature/contact_input/reducer/contact_input_reducer.dart';
import 'package:flutter_claude/feature/contact_input/state/contact_input_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contact_input_view_model.g.dart';

@riverpod
class ContactInputViewModel extends _$ContactInputViewModel
    with BaseViewModel<ContactInputState, ContactInputAction> {
  late final _effect = ContactInputEffect(ref, dispatch);

  @override
  ContactInputState build() => buildInitialState();

  @override
  ContactInputState buildInitialState() => const ContactInputState();

  @override
  ContactInputState reduce(ContactInputState state, ContactInputAction action) =>
      contactInputReducer(state, action);

  @override
  Future<void> handleEffect(ContactInputAction action) =>
      _effect.handleEffect(action);
}
