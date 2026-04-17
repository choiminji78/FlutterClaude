import 'package:drift/drift.dart';
import 'package:flutter_claude/core/storage/database/drift/drift_database_service.dart';
import 'package:flutter_claude/domain/contact/entity/contact_entity.dart';

class ContactDriftMapper {
  const ContactDriftMapper();

  ContactEntity toDomain(ContactTableData data) {
    return ContactEntity(
      id: data.id,
      name: data.name,
      phone: data.phone,
    );
  }

  // INSERT용: autoIncrement PK는 Value.absent() (DB 자동 생성)
  ContactTableCompanion toInsertCompanion(ContactEntity entity) {
    return ContactTableCompanion(
      name: Value(entity.name),
      phone: Value(entity.phone),
    );
  }
}
