import 'package:flutter_claude/domain/common/entity/app_result.dart';
import 'package:flutter_claude/domain/common/exception/app_exception.dart';
import 'package:flutter_claude/domain/contact/entity/contact_entity.dart';
import 'package:flutter_claude/domain/contact/repository/contact_repository.dart';
import 'package:flutter_claude/domain/contact/usecase/load_contact_from_prefs_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'load_contact_from_prefs_usecase_test.mocks.dart';

@GenerateMocks([ContactRepository])
void main() {
  late MockContactRepository mockRepository;
  late LoadContactFromPrefsUseCase useCase;

  const testEntity = ContactEntity(id: 0, name: '홍길동', phone: '010-1234-5678');

  setUp(() {
    provideDummy<AppResult<ContactEntity?>>(const AppResult.success(null));
    mockRepository = MockContactRepository();
    useCase = LoadContactFromPrefsUseCase(mockRepository);
  });

  group('LoadContactFromPrefsUseCase', () {
    test('repository 성공 시 ContactEntity를 포함한 AppSuccess를 반환한다', () async {
      when(mockRepository.readContactFromPrefs())
          .thenAnswer((_) async => const AppResult.success(testEntity));

      final result = await useCase();

      result.when(
        success: (contact) {
          expect(contact?.name, testEntity.name);
          expect(contact?.phone, testEntity.phone);
        },
        failure: (_) => fail('success 기대'),
      );
      verify(mockRepository.readContactFromPrefs()).called(1);
    });

    test('저장된 데이터가 없으면 null을 포함한 AppSuccess를 반환한다', () async {
      when(mockRepository.readContactFromPrefs())
          .thenAnswer((_) async => const AppResult.success(null));

      final result = await useCase();

      result.when(
        success: (contact) => expect(contact, isNull),
        failure: (_) => fail('success 기대'),
      );
    });

    test('repository 실패 시 AppFailure를 반환한다', () async {
      when(mockRepository.readContactFromPrefs()).thenAnswer(
        (_) async => AppResult<ContactEntity?>.failure(const AppException.unknown('error')),
      );

      final result = await useCase();

      expect(result, isA<AppFailure<ContactEntity?>>());
      verify(mockRepository.readContactFromPrefs()).called(1);
    });
  });
}
