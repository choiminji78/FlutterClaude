import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_claude/core/storage/database/drift/tables/contact_table.dart';

part 'drift_database_service.g.dart';

@DriftDatabase(tables: [ContactTable])
class DriftDatabaseService extends _$DriftDatabaseService {
  DriftDatabaseService() : super(_openConnection());

  /// 테스트 전용 생성자. 프로덕션 코드에서는 사용 금지.
  DriftDatabaseService.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async => m.createAll(),
      );

  static QueryExecutor _openConnection() => driftDatabase(name: 'app_database');
}
