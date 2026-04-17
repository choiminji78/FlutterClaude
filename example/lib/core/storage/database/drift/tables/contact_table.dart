import 'package:drift/drift.dart';

@DataClassName('ContactTableData')
class ContactTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get phone => text()();

  @override
  String get tableName => 'contact';
}
