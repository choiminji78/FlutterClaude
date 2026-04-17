import 'package:flutter_claude/core/storage/common/dto/storage_response.dart';
import 'package:flutter_claude/core/storage/common/exception/storage_exception.dart';
import 'package:flutter_claude/core/storage/database/drift/drift_database_service.dart';
import 'package:flutter_claude/data/common/mapper/storage_exception_mapper.dart';
import 'package:flutter_claude/data/contact/datasource/local/contact_local_data_source.dart';
import 'package:flutter_claude/data/contact/mapper/contact_drift_mapper.dart';
import 'package:flutter_claude/data/contact/repository/contact_repository_impl.dart';
import 'package:flutter_claude/domain/common/entity/app_result.dart';
import 'package:flutter_claude/domain/contact/entity/contact_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'contact_repository_impl_test.mocks.dart';

@GenerateMocks([ContactLocalDataSource])
void main() {
  late ContactRepositoryImpl repository;
  late MockContactLocalDataSource mockDataSource;

  setUp(() {
    provideDummy<StorageResponse<String>>(const StorageResponse.success(''));
    provideDummy<StorageResponse<void>>(const StorageResponse.success(null));
    provideDummy<StorageResponse<List<ContactTableData>>>(
      const StorageResponse.success([]),
    );
    mockDataSource = MockContactLocalDataSource();
    repository = ContactRepositoryImpl(
      localDataSource: mockDataSource,
      storageExceptionMapper: const StorageExceptionMapper(),
      driftMapper: const ContactDriftMapper(),
    );
  });

  group('ContactRepositoryImpl', () {
    const testName = '홍길동';
    const testPhone = '010-1234-5678';
    const testEntity = ContactEntity(id: 0, name: testName, phone: testPhone);

    // ── SharedPreferences ────────────────────────────────────────
    group('readContactFromPrefs', () {
      test('이름과 전화번호가 모두 있으면 ContactEntity를 반환한다', () async {
        when(mockDataSource.getNameFromPrefs())
            .thenAnswer((_) async => const StorageResponse.success(testName));
        when(mockDataSource.getPhoneFromPrefs())
            .thenAnswer((_) async => const StorageResponse.success(testPhone));

        final result = await repository.readContactFromPrefs();

        result.when(
          success: (contact) {
            expect(contact?.name, testName);
            expect(contact?.phone, testPhone);
          },
          failure: (_) => fail('success 기대'),
        );
      });

      test('이름이 없으면 null을 반환한다', () async {
        when(mockDataSource.getNameFromPrefs()).thenAnswer(
          (_) async => StorageResponse.failure(StorageException.notFound('Name not found')),
        );
        when(mockDataSource.getPhoneFromPrefs())
            .thenAnswer((_) async => const StorageResponse.success(testPhone));

        final result = await repository.readContactFromPrefs();

        result.when(
          success: (contact) => expect(contact, isNull),
          failure: (_) => fail('success 기대'),
        );
      });

      test('전화번호가 없으면 null을 반환한다', () async {
        when(mockDataSource.getNameFromPrefs())
            .thenAnswer((_) async => const StorageResponse.success(testName));
        when(mockDataSource.getPhoneFromPrefs()).thenAnswer(
          (_) async => StorageResponse.failure(StorageException.notFound('Phone not found')),
        );

        final result = await repository.readContactFromPrefs();

        result.when(
          success: (contact) => expect(contact, isNull),
          failure: (_) => fail('success 기대'),
        );
      });
    });

    group('writeContactToPrefs', () {
      test('성공 시 AppSuccess를 반환한다', () async {
        when(mockDataSource.setNameToPrefs(testName))
            .thenAnswer((_) async => const StorageResponse.success(null));
        when(mockDataSource.setPhoneToPrefs(testPhone))
            .thenAnswer((_) async => const StorageResponse.success(null));

        final result = await repository.writeContactToPrefs(testEntity);

        result.when(
          success: (_) => expect(true, true),
          failure: (_) => fail('success 기대'),
        );
      });

      test('이름 저장 실패 시 AppFailure를 반환한다', () async {
        when(mockDataSource.setNameToPrefs(testName)).thenAnswer(
          (_) async => StorageResponse.failure(
            StorageException.general('write failed'),
          ),
        );

        final result = await repository.writeContactToPrefs(testEntity);

        expect(result, isA<AppFailure<void>>());
      });

      test('전화번호 저장 실패 시 AppFailure를 반환한다', () async {
        when(mockDataSource.setNameToPrefs(testName))
            .thenAnswer((_) async => const StorageResponse.success(null));
        when(mockDataSource.setPhoneToPrefs(testPhone)).thenAnswer(
          (_) async => StorageResponse.failure(
            StorageException.general('write failed'),
          ),
        );

        final result = await repository.writeContactToPrefs(testEntity);

        expect(result, isA<AppFailure<void>>());
      });
    });

    // ── SecureStorage ────────────────────────────────────────────
    group('readContactFromSecure', () {
      test('이름과 전화번호가 모두 있으면 ContactEntity를 반환한다', () async {
        when(mockDataSource.readNameFromSecure())
            .thenAnswer((_) async => const StorageResponse.success(testName));
        when(mockDataSource.readPhoneFromSecure())
            .thenAnswer((_) async => const StorageResponse.success(testPhone));

        final result = await repository.readContactFromSecure();

        result.when(
          success: (contact) {
            expect(contact?.name, testName);
            expect(contact?.phone, testPhone);
          },
          failure: (_) => fail('success 기대'),
        );
      });

      test('이름이 없으면 null을 반환한다', () async {
        when(mockDataSource.readNameFromSecure()).thenAnswer(
          (_) async => StorageResponse.failure(
            StorageException.notFound('Name not found'),
          ),
        );
        when(mockDataSource.readPhoneFromSecure())
            .thenAnswer((_) async => const StorageResponse.success(testPhone));

        final result = await repository.readContactFromSecure();

        result.when(
          success: (contact) => expect(contact, isNull),
          failure: (_) => fail('success 기대'),
        );
      });

      test('전화번호가 없으면 null을 반환한다', () async {
        when(mockDataSource.readNameFromSecure())
            .thenAnswer((_) async => const StorageResponse.success(testName));
        when(mockDataSource.readPhoneFromSecure()).thenAnswer(
          (_) async => StorageResponse.failure(
            StorageException.notFound('Phone not found'),
          ),
        );

        final result = await repository.readContactFromSecure();

        result.when(
          success: (contact) => expect(contact, isNull),
          failure: (_) => fail('success 기대'),
        );
      });
    });

    group('writeContactToSecure', () {
      test('성공 시 AppSuccess를 반환한다', () async {
        when(mockDataSource.writeNameToSecure(testName))
            .thenAnswer((_) async => const StorageResponse.success(null));
        when(mockDataSource.writePhoneToSecure(testPhone))
            .thenAnswer((_) async => const StorageResponse.success(null));

        final result = await repository.writeContactToSecure(testEntity);

        result.when(
          success: (_) => expect(true, true),
          failure: (_) => fail('success 기대'),
        );
      });

      test('이름 저장 실패 시 AppFailure를 반환한다', () async {
        when(mockDataSource.writeNameToSecure(testName)).thenAnswer(
          (_) async => StorageResponse.failure(
            StorageException.general('write failed'),
          ),
        );

        final result = await repository.writeContactToSecure(testEntity);

        expect(result, isA<AppFailure<void>>());
      });

      test('전화번호 저장 실패 시 AppFailure를 반환한다', () async {
        when(mockDataSource.writeNameToSecure(testName))
            .thenAnswer((_) async => const StorageResponse.success(null));
        when(mockDataSource.writePhoneToSecure(testPhone)).thenAnswer(
          (_) async => StorageResponse.failure(
            StorageException.general('write failed'),
          ),
        );

        final result = await repository.writeContactToSecure(testEntity);

        expect(result, isA<AppFailure<void>>());
      });
    });

    // ── Drift ────────────────────────────────────────────────────
    group('getAllContacts', () {
      test('성공 시 AppSuccess와 ContactEntity 목록을 반환한다', () async {
        final tableRows = [
          ContactTableData(id: 1, name: testName, phone: testPhone),
        ];
        when(mockDataSource.getAllContacts())
            .thenAnswer((_) async => StorageResponse.success(tableRows));

        final result = await repository.getAllContacts();

        result.when(
          success: (list) {
            expect(list.length, 1);
            expect(list.first.name, testName);
            expect(list.first.phone, testPhone);
          },
          failure: (_) => fail('success 기대'),
        );
      });

      test('실패 시 AppFailure를 반환한다', () async {
        when(mockDataSource.getAllContacts()).thenAnswer(
          (_) async => StorageResponse.failure(
            StorageException.general('db error'),
          ),
        );

        final result = await repository.getAllContacts();

        expect(result, isA<AppFailure<List<ContactEntity>>>());
      });
    });

    group('insertContact', () {
      test('성공 시 AppSuccess를 반환한다', () async {
        when(mockDataSource.insertContact(companion: anyNamed('companion')))
            .thenAnswer((_) async => const StorageResponse.success(null));

        final result = await repository.insertContact(testEntity);

        result.when(
          success: (_) => expect(true, true),
          failure: (_) => fail('success 기대'),
        );
      });

      test('실패 시 AppFailure를 반환한다', () async {
        when(mockDataSource.insertContact(companion: anyNamed('companion')))
            .thenAnswer(
          (_) async => StorageResponse.failure(
            StorageException.general('insert failed'),
          ),
        );

        final result = await repository.insertContact(testEntity);

        expect(result, isA<AppFailure<void>>());
      });
    });

    group('deleteContact', () {
      test('성공 시 AppSuccess를 반환한다', () async {
        when(mockDataSource.deleteContact(id: 1))
            .thenAnswer((_) async => const StorageResponse.success(null));

        final result = await repository.deleteContact(id: 1);

        result.when(
          success: (_) => expect(true, true),
          failure: (_) => fail('success 기대'),
        );
      });

      test('실패 시 AppFailure를 반환한다', () async {
        when(mockDataSource.deleteContact(id: 1)).thenAnswer(
          (_) async => StorageResponse.failure(
            StorageException.general('delete failed'),
          ),
        );

        final result = await repository.deleteContact(id: 1);

        expect(result, isA<AppFailure<void>>());
      });
    });
  });
}
