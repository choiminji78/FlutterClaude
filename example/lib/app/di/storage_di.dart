import 'package:flutter_claude/core/storage/database/drift/drift_database_service.dart';
import 'package:flutter_claude/core/storage/preferences/preferences_service.dart';
import 'package:flutter_claude/core/storage/secure_storage/secure_storage_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'storage_di.g.dart';

@Riverpod(keepAlive: true)
Future<PreferencesService> preferencesService(PreferencesServiceRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  return PreferencesService(prefs);
}

@Riverpod(keepAlive: true)
SecureStorageService secureStorageService(SecureStorageServiceRef ref) {
  return SecureStorageService();
}

@Riverpod(keepAlive: true)
DriftDatabaseService driftDatabaseService(DriftDatabaseServiceRef ref) {
  return DriftDatabaseService();
}
