// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database_service.dart';

// ignore_for_file: type=lint
class $ContactTableTable extends ContactTable
    with TableInfo<$ContactTableTable, ContactTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, phone];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contact';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContactTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContactTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContactTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
    );
  }

  @override
  $ContactTableTable createAlias(String alias) {
    return $ContactTableTable(attachedDatabase, alias);
  }
}

class ContactTableData extends DataClass
    implements Insertable<ContactTableData> {
  final int id;
  final String name;
  final String phone;
  const ContactTableData({
    required this.id,
    required this.name,
    required this.phone,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    return map;
  }

  ContactTableCompanion toCompanion(bool nullToAbsent) {
    return ContactTableCompanion(
      id: Value(id),
      name: Value(name),
      phone: Value(phone),
    );
  }

  factory ContactTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContactTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
    };
  }

  ContactTableData copyWith({int? id, String? name, String? phone}) =>
      ContactTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
      );
  ContactTableData copyWithCompanion(ContactTableCompanion data) {
    return ContactTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContactTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, phone);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContactTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone);
}

class ContactTableCompanion extends UpdateCompanion<ContactTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> phone;
  const ContactTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
  });
  ContactTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String phone,
  }) : name = Value(name),
       phone = Value(phone);
  static Insertable<ContactTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
    });
  }

  ContactTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? phone,
  }) {
    return ContactTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone')
          ..write(')'))
        .toString();
  }
}

abstract class _$DriftDatabaseService extends GeneratedDatabase {
  _$DriftDatabaseService(QueryExecutor e) : super(e);
  $DriftDatabaseServiceManager get managers =>
      $DriftDatabaseServiceManager(this);
  late final $ContactTableTable contactTable = $ContactTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [contactTable];
}

typedef $$ContactTableTableCreateCompanionBuilder =
    ContactTableCompanion Function({
      Value<int> id,
      required String name,
      required String phone,
    });
typedef $$ContactTableTableUpdateCompanionBuilder =
    ContactTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> phone,
    });

class $$ContactTableTableFilterComposer
    extends Composer<_$DriftDatabaseService, $ContactTableTable> {
  $$ContactTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ContactTableTableOrderingComposer
    extends Composer<_$DriftDatabaseService, $ContactTableTable> {
  $$ContactTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ContactTableTableAnnotationComposer
    extends Composer<_$DriftDatabaseService, $ContactTableTable> {
  $$ContactTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);
}

class $$ContactTableTableTableManager
    extends
        RootTableManager<
          _$DriftDatabaseService,
          $ContactTableTable,
          ContactTableData,
          $$ContactTableTableFilterComposer,
          $$ContactTableTableOrderingComposer,
          $$ContactTableTableAnnotationComposer,
          $$ContactTableTableCreateCompanionBuilder,
          $$ContactTableTableUpdateCompanionBuilder,
          (
            ContactTableData,
            BaseReferences<
              _$DriftDatabaseService,
              $ContactTableTable,
              ContactTableData
            >,
          ),
          ContactTableData,
          PrefetchHooks Function()
        > {
  $$ContactTableTableTableManager(
    _$DriftDatabaseService db,
    $ContactTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContactTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContactTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContactTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> phone = const Value.absent(),
              }) => ContactTableCompanion(id: id, name: name, phone: phone),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String phone,
              }) => ContactTableCompanion.insert(
                id: id,
                name: name,
                phone: phone,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ContactTableTableProcessedTableManager =
    ProcessedTableManager<
      _$DriftDatabaseService,
      $ContactTableTable,
      ContactTableData,
      $$ContactTableTableFilterComposer,
      $$ContactTableTableOrderingComposer,
      $$ContactTableTableAnnotationComposer,
      $$ContactTableTableCreateCompanionBuilder,
      $$ContactTableTableUpdateCompanionBuilder,
      (
        ContactTableData,
        BaseReferences<
          _$DriftDatabaseService,
          $ContactTableTable,
          ContactTableData
        >,
      ),
      ContactTableData,
      PrefetchHooks Function()
    >;

class $DriftDatabaseServiceManager {
  final _$DriftDatabaseService _db;
  $DriftDatabaseServiceManager(this._db);
  $$ContactTableTableTableManager get contactTable =>
      $$ContactTableTableTableManager(_db, _db.contactTable);
}
