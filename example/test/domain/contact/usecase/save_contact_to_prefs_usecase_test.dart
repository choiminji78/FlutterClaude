import 'package:flutter_claude/domain/common/entity/app_result.dart';
import 'package:flutter_claude/domain/common/exception/app_exception.dart';
import 'package:flutter_claude/domain/contact/entity/contact_entity.dart';
import 'package:flutter_claude/domain/contact/repository/contact_repository.dart';
import 'package:flutter_claude/domain/contact/usecase/save_contact_to_prefs_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_contact_to_prefs_usecase_test.mocks.dart';

@GenerateMocks([ContactRepository])
void main() {
  late MockContactRepository mockRepository;
  late SaveContactToPrefsUseCase useCase;

  const testEntity = ContactEntity(id: 0, name: '홍길동', phone: '010-1234-5678');

  setUp(() {
    provideDummy<AppResult<void>>(const AppResult.success(null));
    mockRepository = MockContactRepository();
    useCase = SaveContactToPrefsUseCase(mockRepository);
  });

  group('SaveContactToPrefsUseCase', () {
    test('repository 성공 시 AppSuccess를 반환한다', () async {
      when(mockRepository.writeContactToPrefs(testEntity))
          .thenAnswer((_) async => const AppResult.success(null));

      final result = await useCase(testEntity);

      expect(result, isA<AppSuccess<void>>());
      verify(mockRepository.writeContactToPrefs(testEntity)).called(1);
    });

    test('repository 실패 시 AppFailure를 반환한다', () async {
      when(mockRepository.writeContactToPrefs(testEntity))
          .thenAnswer((_) async => AppResult<void>.failure(const AppException.unknown('error')));

      final result = await useCase(testEntity);

      expect(result, isA<AppFailure<void>>());
      verify(mockRepository.writeContactToPrefs(testEntity)).called(1);
    });
  });
}
