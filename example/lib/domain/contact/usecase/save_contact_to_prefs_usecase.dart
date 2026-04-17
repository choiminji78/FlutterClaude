import 'package:flutter_claude/domain/common/entity/app_result.dart';
import 'package:flutter_claude/domain/contact/entity/contact_entity.dart';
import 'package:flutter_claude/domain/contact/repository/contact_repository.dart';

class SaveContactToPrefsUseCase {
  const SaveContactToPrefsUseCase(this._repository);

  final ContactRepository _repository;

  Future<AppResult<void>> call(ContactEntity entity) =>
      _repository.writeContactToPrefs(entity);
}
