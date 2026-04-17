import 'package:flutter_claude/app/di/storage_di.dart';
import 'package:flutter_claude/data/contact/datasource/local/contact_local_data_source.dart';
import 'package:flutter_claude/data/contact/mapper/contact_drift_mapper.dart';
import 'package:flutter_claude/data/contact/repository/contact_repository_impl.dart';
import 'package:flutter_claude/data/common/mapper/storage_exception_mapper.dart';
import 'package:flutter_claude/domain/contact/repository/contact_repository.dart';
import 'package:flutter_claude/domain/contact/usecase/load_contact_from_prefs_usecase.dart';
import 'package:flutter_claude/domain/contact/usecase/load_contact_from_secure_usecase.dart';
import 'package:flutter_claude/domain/contact/usecase/save_contact_to_prefs_usecase.dart';
import 'package:flutter_claude/domain/contact/usecase/save_contact_to_secure_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contact_di.g.dart';

// 순서 1: DataSource
@Riverpod(keepAlive: true)
Future<ContactLocalDataSource> contactLocalDataSource(
  ContactLocalDataSourceRef ref,
) async {
  final prefs = await ref.read(preferencesServiceProvider.future);
  final secureStorage = ref.read(secureStorageServiceProvider);
  final driftDb = ref.read(driftDatabaseServiceProvider);
  return ContactLocalDataSourceImpl(
    preferencesService: prefs,
    secureStorageService: secureStorage,
    driftDatabaseService: driftDb,
  );
}

// 순서 2: Repository
@Riverpod(keepAlive: true)
Future<ContactRepository> contactRepository(ContactRepositoryRef ref) async {
  final ds = await ref.read(contactLocalDataSourceProvider.future);
  return ContactRepositoryImpl(
    localDataSource: ds,
    storageExceptionMapper: const StorageExceptionMapper(),
    driftMapper: const ContactDriftMapper(),
  );
}

// 순서 3: UseCase
@Riverpod(keepAlive: true)
Future<SaveContactToPrefsUseCase> saveContactToPrefsUseCase(
  SaveContactToPrefsUseCaseRef ref,
) async {
  final repo = await ref.read(contactRepositoryProvider.future);
  return SaveContactToPrefsUseCase(repo);
}

@Riverpod(keepAlive: true)
Future<LoadContactFromPrefsUseCase> loadContactFromPrefsUseCase(
  LoadContactFromPrefsUseCaseRef ref,
) async {
  final repo = await ref.read(contactRepositoryProvider.future);
  return LoadContactFromPrefsUseCase(repo);
}

@Riverpod(keepAlive: true)
Future<SaveContactToSecureUseCase> saveContactToSecureUseCase(
  SaveContactToSecureUseCaseRef ref,
) async {
  final repo = await ref.read(contactRepositoryProvider.future);
  return SaveContactToSecureUseCase(repo);
}

@Riverpod(keepAlive: true)
Future<LoadContactFromSecureUseCase> loadContactFromSecureUseCase(
  LoadContactFromSecureUseCaseRef ref,
) async {
  final repo = await ref.read(contactRepositoryProvider.future);
  return LoadContactFromSecureUseCase(repo);
}
