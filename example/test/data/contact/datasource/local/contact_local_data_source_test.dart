import 'package:drift/drift.dart' show LazyDatabase, Value, driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_claude/core/storage/common/dto/storage_response.dart';
import 'package:flutter_claude/core/storage/common/exception/storage_exception.dart';
import 'package:flutter_claude/core/storage/database/drift/drift_database_service.dart';
import 'package:flutter_claude/core/storage/preferences/preferences_service.dart';
import 'package:flutter_claude/core/storage/secure_storage/secure_storage_service.dart';
import 'package:flutter_claude/data/contact/datasource/local/contact_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'contact_local_data_source_test.mocks.dart';

@GenerateMocks([PreferencesService, SecureStorageService])
void main() {
  late MockPreferencesService mockPrefs;
  late MockSecureStorageService mockSecure;
  late DriftDatabaseService db;
  late ContactLocalDataSourceImpl dataSource;

  setUpAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  setUp(() {
    mockPrefs = MockPreferencesService();
    mockSecure = MockSecureStorageService();
    db = DriftDatabaseService.forTesting(NativeDatabase.memory());
    dataSource = ContactLocalDataSourceImpl(
      preferencesService: mockPrefs,
      secureStorageService: mockSecure,
      driftDatabaseService: db,
    );
  });

  tearDown(() async {
    try {
      await db.close();
    } catch (_) {}
  });

  /// DB 작업이 무조건 실패하는 DataSource 인스턴스를 생성한다.
  /// LazyDatabase opener에서 throw해 catch(e) 경로를 검증한다.
  ContactLocalDataSourceImpl makeFailingDriftDataSource() {
    final failingDb = DriftDatabaseService.forTesting(
      LazyDatabase(() async => throw Exception('Simulated DB error')),
    );
    return ContactLocalDataSourceImpl(
      preferencesService: mockPrefs,
      secureStorageService: mockSecure,
      driftDatabaseService: failingDb,
    );
  }

  group('ContactLocalDataSourceImpl', () {
    const testName = '홍길동';
    const testPhone = '010-1234-5678';

    // ── SharedPreferences ─────────────────────────────────────────

    group('getNameFromPrefs', () {
      test('값이 있으면 StorageSuccess를 반환한다', () async {
        when(mockPrefs.getString(any)).thenReturn(testName);

        final result = await dataSource.getNameFromPrefs();

        result.when(
          success: (v) => expect(v, testName),
          failure: (_) => fail('success 기대'),
        );
      });

      test('값이 없으면 StorageFailure(notFound)를 반환한다', () async {
        when(mockPrefs.getString(any)).thenReturn(null);

        final result = await dataSource.getNameFromPrefs();

        result.when(
          success: (_) => fail('failure 기대'),
          failure: (e) => e.when(
            notFound: (msg) => expect(msg, isNotEmpty),
            general: (_) => fail('notFound 기대'),
          ),
        );
      });
    });

    group('setNameToPrefs', () {
      test('저장 성공 시 StorageSuccess를 반환한다', () async {
        when(mockPrefs.setString(any, testName)).thenAnswer((_) async {});

        final result = await dataSource.setNameToPrefs(testName);

        result.when(
          success: (_) => expect(true, true),
          failure: (_) => fail('success 기대'),
        );
      });

      test('예외 발생 시 StorageFailure(general)를 반환한다', () async {
        when(mockPrefs.setString(any, testName))
            .thenThrow(Exception('prefs write error'));

        final result = await dataSource.setNameToPrefs(testName);

        result.when(
          success: (_) => fail('failure 기대'),
          failure: (e) => e.when(
            notFound: (_) => fail('general 기대'),
            general: (msg) => expect(msg, contains('prefs write error')),
          ),
        );
      });
    });

    group('getPhoneFromPrefs', () {
      test('값이 있으면 StorageSuccess를 반환한다', () async {
        when(mockPrefs.getString(any)).thenReturn(testPhone);

        final result = await dataSource.getPhoneFromPrefs();

        result.when(
          success: (v) => expect(v, testPhone),
          failure: (_) => fail('success 기대'),
        );
      });

      test('값이 없으면 StorageFailure(notFound)를 반환한다', () async {
        when(mockPrefs.getString(any)).thenReturn(null);

        final result = await dataSource.getPhoneFromPrefs();

        result.when(
          success: (_) => fail('failure 기대'),
          failure: (e) => e.when(
            notFound: (msg) => expect(msg, isNotEmpty),
            general: (_) => fail('notFound 기대'),
          ),
        );
      });
    });

    group('setPhoneToPrefs', () {
      test('저장 성공 시 StorageSuccess를 반환한다', () async {
        when(mockPrefs.setString(any, testPhone)).thenAnswer((_) async {});

        final result = await dataSource.setPhoneToPrefs(testPhone);

        result.when(
          success: (_) => expect(true, true),
          failure: (_) => fail('success 기대'),
        );
      });

      test('예외 발생 시 StorageFailure(general)를 반환한다', () async {
        when(mockPrefs.setString(any, testPhone))
            .thenThrow(Exception('prefs write error'));

        final result = await dataSource.setPhoneToPrefs(testPhone);

        result.when(
          success: (_) => fail('failure 기대'),
          failure: (e) => e.when(
            notFound: (_) => fail('general 기대'),
            general: (msg) => expect(msg, contains('prefs write error')),
          ),
        );
      });
    });

    // ── SecureStorage ─────────────────────────────────────────────

    group('readNameFromSecure', () {
      test('값이 있으면 StorageSuccess를 반환한다', () async {
        when(mockSecure.read(key: anyNamed('key')))
            .thenAnswer((_) async => testName);

        final result = await dataSource.readNameFromSecure();

        result.when(
          success: (v) => expect(v, testName),
          failure: (_) => fail('success 기대'),
        );
      });

      test('값이 없으면 StorageFailure(notFound)를 반환한다', () async {
        when(mockSecure.read(key: anyNamed('key')))
            .thenAnswer((_) async => null);

        final result = await dataSource.readNameFromSecure();

        result.when(
          success: (_) => fail('failure 기대'),
          failure: (e) => e.when(
            notFound: (msg) => expect(msg, isNotEmpty),
            general: (_) => fail('notFound 기대'),
          ),
        );
      });

      test('예외 발생 시 StorageFailure(general)를 반환한다', () async {
        when(mockSecure.read(key: anyNamed('key')))
            .thenThrow(Exception('secure read error'));

        final result = await dataSource.readNameFromSecure();

        result.when(
          success: (_) => fail('failure 기대'),
          failure: (e) => e.when(
            notFound: (_) => fail('general 기대'),
            general: (msg) => expect(msg, contains('secure read error')),
          ),
        );
      });
    });

    group('writeNameToSecure', () {
      test('저장 성공 시 StorageSuccess를 반환한다', () async {
        when(mockSecure.write(key: anyNamed('key'), value: anyNamed('value')))
            .thenAnswer((_) async {});

        final result = await dataSource.writeNameToSecure(testName);

        result.when(
          success: (_) => expect(true, true),
          failure: (_) => fail('success 기대'),
        );
      });

      test('예외 발생 시 StorageFailure(general)를 반환한다', () async {
        when(mockSecure.write(key: anyNamed('key'), value: anyNamed('value')))
            .thenThrow(Exception('secure write error'));

        final result = await dataSource.writeNameToSecure(testName);

        result.when(
          success: (_) => fail('failure 기대'),
          failure: (e) => e.when(
            notFound: (_) => fail('general 기대'),
            general: (msg) => expect(msg, contains('secure write error')),
          ),
        );
      });
    });

    group('readPhoneFromSecure', () {
      test('값이 있으면 StorageSuccess를 반환한다', () async {
        when(mockSecure.read(key: anyNamed('key')))
            .thenAnswer((_) async => testPhone);

        final result = await dataSource.readPhoneFromSecure();

        result.when(
          success: (v) => expect(v, testPhone),
          failure: (_) => fail('success 기대'),
        );
      });

      test('값이 없으면 StorageFailure(notFound)를 반환한다', () async {
        when(mockSecure.read(key: anyNamed('key')))
            .thenAnswer((_) async => null);

        final result = await dataSource.readPhoneFromSecure();

        result.when(
          success: (_) => fail('failure 기대'),
          failure: (e) => e.when(
            notFound: (msg) => expect(msg, isNotEmpty),
            general: (_) => fail('notFound 기대'),
          ),
        );
      });

      test('예외 발생 시 StorageFailure(general)를 반환한다', () async {
        when(mockSecure.read(key: anyNamed('key')))
            .thenThrow(Exception('secure read error'));

        final result = await dataSource.readPhoneFromSecure();

        result.when(
          success: (_) => fail('failure 기대'),
          failure: (e) => e.when(
            notFound: (_) => fail('general 기대'),
            general: (msg) => expect(msg, contains('secure read error')),
          ),
        );
      });
    });

    group('writePhoneToSecure', () {
      test('저장 성공 시 StorageSuccess를 반환한다', () async {
        when(mockSecure.write(key: anyNamed('key'), value: anyNamed('value')))
            .thenAnswer((_) async {});

        final result = await dataSource.writePhoneToSecure(testPhone);

        result.when(
          success: (_) => expect(true, true),
          failure: (_) => fail('success 기대'),
        );
      });

      test('예외 발생 시 StorageFailure(general)를 반환한다', () async {
        when(mockSecure.write(key: anyNamed('key'), value: anyNamed('value')))
            .thenThrow(Exception('secure write error'));

        final result = await dataSource.writePhoneToSecure(testPhone);

        result.when(
          success: (_) => fail('failure 기대'),
          failure: (e) => e.when(
            notFound: (_) => fail('general 기대'),
            general: (msg) => expect(msg, contains('secure write error')),
          ),
        );
      });
    });

    // ── Drift ─────────────────────────────────────────────────────

    group('getAllContacts', () {
      test('빈 DB에서 빈 목록을 반환한다', () async {
        final result = await dataSource.getAllContacts();

        result.when(
          success: (list) => expect(list, isEmpty),
          failure: (_) => fail('success 기대'),
        );
      });

      test('삽입된 데이터가 있으면 목록을 반환한다', () async {
        await dataSource.insertContact(
          companion: ContactTableCompanion(
            name: Value(testName),
            phone: Value(testPhone),
          ),
        );

        final result = await dataSource.getAllContacts();

        result.when(
          success: (list) {
            expect(list.length, 1);
            expect(list.first.name, testName);
            expect(list.first.phone, testPhone);
          },
          failure: (_) => fail('success 기대'),
        );
      });

      test('DB 오류 시 StorageFailure를 반환한다', () async {
        final result = await makeFailingDriftDataSource().getAllContacts();
        expect(result, isA<StorageFailure<List<ContactTableData>>>());
      });
    });

    group('insertContact', () {
      test('성공 시 StorageSuccess를 반환한다', () async {
        final result = await dataSource.insertContact(
          companion: ContactTableCompanion(
            name: Value(testName),
            phone: Value(testPhone),
          ),
        );

        result.when(
          success: (_) => expect(true, true),
          failure: (_) => fail('success 기대'),
        );
      });

      test('삽입 후 getAllContacts로 조회되어야 한다', () async {
        await dataSource.insertContact(
          companion: ContactTableCompanion(
            name: Value(testName),
            phone: Value(testPhone),
          ),
        );

        (await dataSource.getAllContacts()).when(
          success: (list) {
            expect(list.length, 1);
            expect(list.first.name, testName);
          },
          failure: (_) => fail('success 기대'),
        );
      });

      test('DB 오류 시 StorageFailure를 반환한다', () async {
        final result = await makeFailingDriftDataSource().insertContact(
          companion: ContactTableCompanion(
            name: Value(testName),
            phone: Value(testPhone),
          ),
        );
        expect(result, isA<StorageFailure<void>>());
      });
    });

    group('deleteContact', () {
      test('존재하는 행을 삭제하면 StorageSuccess를 반환한다', () async {
        await dataSource.insertContact(
          companion: ContactTableCompanion(
            name: Value(testName),
            phone: Value(testPhone),
          ),
        );

        late int insertedId;
        (await dataSource.getAllContacts()).when(
          success: (list) => insertedId = list.first.id,
          failure: (_) => fail('사전 조회 실패'),
        );

        final result = await dataSource.deleteContact(id: insertedId);

        result.when(
          success: (_) => expect(true, true),
          failure: (_) => fail('success 기대'),
        );
      });

      test('삭제 후 getAllContacts에서 해당 행이 없어야 한다', () async {
        await dataSource.insertContact(
          companion: ContactTableCompanion(
            name: Value(testName),
            phone: Value(testPhone),
          ),
        );

        late int insertedId;
        (await dataSource.getAllContacts()).when(
          success: (list) => insertedId = list.first.id,
          failure: (_) => fail('사전 조회 실패'),
        );

        await dataSource.deleteContact(id: insertedId);

        (await dataSource.getAllContacts()).when(
          success: (list) => expect(list, isEmpty),
          failure: (_) => fail('사후 조회 실패'),
        );
      });

      test('DB 오류 시 StorageFailure를 반환한다', () async {
        final result = await makeFailingDriftDataSource().deleteContact(id: 1);
        expect(result, isA<StorageFailure<void>>());
      });
    });
  });
}
