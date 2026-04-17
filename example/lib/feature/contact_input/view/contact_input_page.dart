import 'package:flutter/material.dart';
import 'package:flutter_claude/app/viewmodel/app_view_model.dart';
import 'package:flutter_claude/domain/contact/entity/contact_entity.dart';
import 'package:flutter_claude/feature/contact_input/action/contact_input_action.dart';
import 'package:flutter_claude/feature/contact_input/viewmodel/contact_input_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactInputPage extends ConsumerWidget {
  const ContactInputPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(contactInputViewModelProvider);
    final notifier = ref.read(contactInputViewModelProvider.notifier);

    ref.listen(contactInputViewModelProvider, (prev, next) {
      if (next.error != null && prev?.error != next.error) {
        ref.read(appViewModelProvider.notifier).showError(
          next.error!.when(
            network: (msg) => '네트워크 오류: $msg',
            server: (code, msg) => '서버 오류 $code: $msg',
            unauthorized: (msg) => '인증 오류: $msg',
            forbidden: (msg) => '접근 거부: $msg',
            notFound: (msg) => '찾을 수 없음: $msg',
            timeout: (msg) => '시간 초과: $msg',
            unknown: (msg) => '오류: $msg',
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('연락처 입력')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── 입력 영역 ──
            TextField(
              decoration: const InputDecoration(
                labelText: '이름',
                hintText: '이름을 입력하세요',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) =>
                  notifier.dispatch(ContactInputAction.nameInputChanged(value)),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                labelText: '전화번호',
                hintText: '전화번호를 입력하세요',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) =>
                  notifier.dispatch(ContactInputAction.phoneInputChanged(value)),
            ),
            const SizedBox(height: 32),

            // ── SharedPreferences 섹션 ──
            _StorageSection(
              title: 'SharedPreferences',
              titleColor: Colors.blue,
              isLoading: state.isLoading,
              loadedName: state.prefsLoadedContact?.name,
              loadedPhone: state.prefsLoadedContact?.phone,
              onSave: () => notifier.dispatch(
                ContactInputAction.saveToPrefsStarted(
                  ContactEntity(
                    id: 0,
                    name: state.nameInput,
                    phone: state.phoneInput,
                  ),
                ),
              ),
              onLoad: () =>
                  notifier.dispatch(ContactInputAction.loadFromPrefsStarted()),
            ),
            const SizedBox(height: 24),

            // ── SecureStorage 섹션 ──
            _StorageSection(
              title: 'SecureStorage',
              titleColor: Colors.green,
              isLoading: state.isLoading,
              loadedName: state.secureLoadedContact?.name,
              loadedPhone: state.secureLoadedContact?.phone,
              onSave: () => notifier.dispatch(
                ContactInputAction.saveToSecureStarted(
                  ContactEntity(
                    id: 0,
                    name: state.nameInput,
                    phone: state.phoneInput,
                  ),
                ),
              ),
              onLoad: () =>
                  notifier.dispatch(ContactInputAction.loadFromSecureStarted()),
            ),
            const SizedBox(height: 24),

            // ── Drift 섹션 ──
            _DriftSection(
              isLoading: state.isLoading,
              contacts: state.driftLoadedContacts,
              onSave: () => notifier.dispatch(
                ContactInputAction.saveToDriftStarted(
                  ContactEntity(
                    id: 0,
                    name: state.nameInput,
                    phone: state.phoneInput,
                  ),
                ),
              ),
              onLoad: () =>
                  notifier.dispatch(ContactInputAction.loadFromDriftStarted()),
            ),
          ],
        ),
      ),
    );
  }
}

class _StorageSection extends StatelessWidget {
  const _StorageSection({
    required this.title,
    required this.titleColor,
    required this.isLoading,
    required this.loadedName,
    required this.loadedPhone,
    required this.onSave,
    required this.onLoad,
  });

  final String title;
  final Color titleColor;
  final bool isLoading;
  final String? loadedName;
  final String? loadedPhone;
  final VoidCallback onSave;
  final VoidCallback onLoad;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: titleColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: titleColor),
                onPressed: isLoading ? null : onSave,
                child: isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('저장'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(foregroundColor: titleColor),
                onPressed: isLoading ? null : onLoad,
                child: const Text('불러오기'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _LoadedValueCard(
          label: '이름',
          value: loadedName,
          accentColor: titleColor,
        ),
        const SizedBox(height: 8),
        _LoadedValueCard(
          label: '전화번호',
          value: loadedPhone,
          accentColor: titleColor,
        ),
      ],
    );
  }
}

class _LoadedValueCard extends StatelessWidget {
  const _LoadedValueCard({
    required this.label,
    required this.value,
    required this.accentColor,
  });

  final String label;
  final String? value;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                  ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                value ?? '저장된 값 없음',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: value == null ? Colors.grey : null,
                      fontStyle:
                          value == null ? FontStyle.italic : FontStyle.normal,
                    ),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DriftSection extends StatelessWidget {
  const _DriftSection({
    required this.isLoading,
    required this.contacts,
    required this.onSave,
    required this.onLoad,
  });

  static const _titleColor = Colors.orange;

  final bool isLoading;
  final List<ContactEntity> contacts;
  final VoidCallback onSave;
  final VoidCallback onLoad;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: _titleColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Drift (SQLite)',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _titleColor,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: _titleColor),
                onPressed: isLoading ? null : onSave,
                child: isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('저장'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(foregroundColor: _titleColor),
                onPressed: isLoading ? null : onLoad,
                child: const Text('불러오기'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (contacts.isEmpty) ...[
          _LoadedValueCard(label: '이름', value: null, accentColor: _titleColor),
          const SizedBox(height: 8),
          _LoadedValueCard(
            label: '전화번호',
            value: null,
            accentColor: _titleColor,
          ),
        ] else
          for (int i = 0; i < contacts.length; i++) ...[
            if (i > 0) const SizedBox(height: 16),
            _LoadedValueCard(
              label: contacts.length == 1 ? '이름' : '이름 ${i + 1}',
              value: contacts[i].name,
              accentColor: _titleColor,
            ),
            const SizedBox(height: 8),
            _LoadedValueCard(
              label: contacts.length == 1 ? '전화번호' : '전화번호 ${i + 1}',
              value: contacts[i].phone,
              accentColor: _titleColor,
            ),
          ],
      ],
    );
  }
}
