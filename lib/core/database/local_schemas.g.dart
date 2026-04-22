// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_schemas.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLocalDailyLogCollection on Isar {
  IsarCollection<LocalDailyLog> get localDailyLogs => this.collection();
}

const LocalDailyLogSchema = CollectionSchema(
  name: r'LocalDailyLog',
  id: -3358754373615931050,
  properties: {
    r'consumedCalories': PropertySchema(
      id: 0,
      name: r'consumedCalories',
      type: IsarType.double,
    ),
    r'consumedCarbs': PropertySchema(
      id: 1,
      name: r'consumedCarbs',
      type: IsarType.double,
    ),
    r'consumedFats': PropertySchema(
      id: 2,
      name: r'consumedFats',
      type: IsarType.double,
    ),
    r'consumedProtein': PropertySchema(
      id: 3,
      name: r'consumedProtein',
      type: IsarType.double,
    ),
    r'isSyncedWithCloud': PropertySchema(
      id: 4,
      name: r'isSyncedWithCloud',
      type: IsarType.bool,
    ),
    r'logDate': PropertySchema(
      id: 5,
      name: r'logDate',
      type: IsarType.dateTime,
    ),
    r'supabaseId': PropertySchema(
      id: 6,
      name: r'supabaseId',
      type: IsarType.string,
    ),
    r'targetCalories': PropertySchema(
      id: 7,
      name: r'targetCalories',
      type: IsarType.double,
    ),
    r'targetProtein': PropertySchema(
      id: 8,
      name: r'targetProtein',
      type: IsarType.double,
    )
  },
  estimateSize: _localDailyLogEstimateSize,
  serialize: _localDailyLogSerialize,
  deserialize: _localDailyLogDeserialize,
  deserializeProp: _localDailyLogDeserializeProp,
  idName: r'id',
  indexes: {
    r'supabaseId': IndexSchema(
      id: 2753382765909358918,
      name: r'supabaseId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'supabaseId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'logDate': IndexSchema(
      id: 8404824101822155242,
      name: r'logDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'logDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'meals': LinkSchema(
      id: -6549275215171219123,
      name: r'meals',
      target: r'LocalMeal',
      single: false,
      linkName: r'dailyLog',
    )
  },
  embeddedSchemas: {},
  getId: _localDailyLogGetId,
  getLinks: _localDailyLogGetLinks,
  attach: _localDailyLogAttach,
  version: '3.1.0+1',
);

int _localDailyLogEstimateSize(
  LocalDailyLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.supabaseId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _localDailyLogSerialize(
  LocalDailyLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.consumedCalories);
  writer.writeDouble(offsets[1], object.consumedCarbs);
  writer.writeDouble(offsets[2], object.consumedFats);
  writer.writeDouble(offsets[3], object.consumedProtein);
  writer.writeBool(offsets[4], object.isSyncedWithCloud);
  writer.writeDateTime(offsets[5], object.logDate);
  writer.writeString(offsets[6], object.supabaseId);
  writer.writeDouble(offsets[7], object.targetCalories);
  writer.writeDouble(offsets[8], object.targetProtein);
}

LocalDailyLog _localDailyLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocalDailyLog();
  object.consumedCalories = reader.readDouble(offsets[0]);
  object.consumedCarbs = reader.readDouble(offsets[1]);
  object.consumedFats = reader.readDouble(offsets[2]);
  object.consumedProtein = reader.readDouble(offsets[3]);
  object.id = id;
  object.isSyncedWithCloud = reader.readBool(offsets[4]);
  object.logDate = reader.readDateTime(offsets[5]);
  object.supabaseId = reader.readStringOrNull(offsets[6]);
  object.targetCalories = reader.readDouble(offsets[7]);
  object.targetProtein = reader.readDouble(offsets[8]);
  return object;
}

P _localDailyLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _localDailyLogGetId(LocalDailyLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _localDailyLogGetLinks(LocalDailyLog object) {
  return [object.meals];
}

void _localDailyLogAttach(
    IsarCollection<dynamic> col, Id id, LocalDailyLog object) {
  object.id = id;
  object.meals.attach(col, col.isar.collection<LocalMeal>(), r'meals', id);
}

extension LocalDailyLogQueryWhereSort
    on QueryBuilder<LocalDailyLog, LocalDailyLog, QWhere> {
  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterWhere> anyLogDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'logDate'),
      );
    });
  }
}

extension LocalDailyLogQueryWhere
    on QueryBuilder<LocalDailyLog, LocalDailyLog, QWhereClause> {
  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterWhereClause>
      supabaseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'supabaseId',
        value: [null],
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterWhereClause>
      supabaseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'supabaseId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterWhereClause>
      supabaseIdEqualTo(String? supabaseId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'supabaseId',
        value: [supabaseId],
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterWhereClause>
      supabaseIdNotEqualTo(String? supabaseId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseId',
              lower: [],
              upper: [supabaseId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseId',
              lower: [supabaseId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseId',
              lower: [supabaseId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseId',
              lower: [],
              upper: [supabaseId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterWhereClause> logDateEqualTo(
      DateTime logDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'logDate',
        value: [logDate],
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterWhereClause>
      logDateNotEqualTo(DateTime logDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'logDate',
              lower: [],
              upper: [logDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'logDate',
              lower: [logDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'logDate',
              lower: [logDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'logDate',
              lower: [],
              upper: [logDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterWhereClause>
      logDateGreaterThan(
    DateTime logDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'logDate',
        lower: [logDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterWhereClause> logDateLessThan(
    DateTime logDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'logDate',
        lower: [],
        upper: [logDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterWhereClause> logDateBetween(
    DateTime lowerLogDate,
    DateTime upperLogDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'logDate',
        lower: [lowerLogDate],
        includeLower: includeLower,
        upper: [upperLogDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LocalDailyLogQueryFilter
    on QueryBuilder<LocalDailyLog, LocalDailyLog, QFilterCondition> {
  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      consumedCaloriesEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'consumedCalories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      consumedCaloriesGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'consumedCalories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      consumedCaloriesLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'consumedCalories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      consumedCaloriesBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'consumedCalories',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      consumedCarbsEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'consumedCarbs',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      consumedCarbsGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'consumedCarbs',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      consumedCarbsLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'consumedCarbs',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      consumedCarbsBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'consumedCarbs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      consumedFatsEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'consumedFats',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      consumedFatsGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'consumedFats',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      consumedFatsLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'consumedFats',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      consumedFatsBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'consumedFats',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      consumedProteinEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'consumedProtein',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      consumedProteinGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'consumedProtein',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      consumedProteinLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'consumedProtein',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      consumedProteinBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'consumedProtein',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      isSyncedWithCloudEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSyncedWithCloud',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      logDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logDate',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      logDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'logDate',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      logDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'logDate',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      logDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'logDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      supabaseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'supabaseId',
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      supabaseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'supabaseId',
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      supabaseIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supabaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      supabaseIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'supabaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      supabaseIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'supabaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      supabaseIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'supabaseId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      supabaseIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'supabaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      supabaseIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'supabaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      supabaseIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'supabaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      supabaseIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'supabaseId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      supabaseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supabaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      supabaseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'supabaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      targetCaloriesEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetCalories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      targetCaloriesGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetCalories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      targetCaloriesLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetCalories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      targetCaloriesBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetCalories',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      targetProteinEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetProtein',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      targetProteinGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetProtein',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      targetProteinLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetProtein',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      targetProteinBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetProtein',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension LocalDailyLogQueryObject
    on QueryBuilder<LocalDailyLog, LocalDailyLog, QFilterCondition> {}

extension LocalDailyLogQueryLinks
    on QueryBuilder<LocalDailyLog, LocalDailyLog, QFilterCondition> {
  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition> meals(
      FilterQuery<LocalMeal> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'meals');
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      mealsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'meals', length, true, length, true);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      mealsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'meals', 0, true, 0, true);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      mealsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'meals', 0, false, 999999, true);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      mealsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'meals', 0, true, length, include);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      mealsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'meals', length, include, 999999, true);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterFilterCondition>
      mealsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'meals', lower, includeLower, upper, includeUpper);
    });
  }
}

extension LocalDailyLogQuerySortBy
    on QueryBuilder<LocalDailyLog, LocalDailyLog, QSortBy> {
  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      sortByConsumedCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedCalories', Sort.asc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      sortByConsumedCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedCalories', Sort.desc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      sortByConsumedCarbs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedCarbs', Sort.asc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      sortByConsumedCarbsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedCarbs', Sort.desc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      sortByConsumedFats() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedFats', Sort.asc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      sortByConsumedFatsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedFats', Sort.desc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      sortByConsumedProtein() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedProtein', Sort.asc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      sortByConsumedProteinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedProtein', Sort.desc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      sortByIsSyncedWithCloud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSyncedWithCloud', Sort.asc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      sortByIsSyncedWithCloudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSyncedWithCloud', Sort.desc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy> sortByLogDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logDate', Sort.asc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy> sortByLogDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logDate', Sort.desc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy> sortBySupabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseId', Sort.asc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      sortBySupabaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseId', Sort.desc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      sortByTargetCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetCalories', Sort.asc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      sortByTargetCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetCalories', Sort.desc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      sortByTargetProtein() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetProtein', Sort.asc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      sortByTargetProteinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetProtein', Sort.desc);
    });
  }
}

extension LocalDailyLogQuerySortThenBy
    on QueryBuilder<LocalDailyLog, LocalDailyLog, QSortThenBy> {
  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      thenByConsumedCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedCalories', Sort.asc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      thenByConsumedCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedCalories', Sort.desc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      thenByConsumedCarbs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedCarbs', Sort.asc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      thenByConsumedCarbsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedCarbs', Sort.desc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      thenByConsumedFats() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedFats', Sort.asc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      thenByConsumedFatsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedFats', Sort.desc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      thenByConsumedProtein() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedProtein', Sort.asc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      thenByConsumedProteinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedProtein', Sort.desc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      thenByIsSyncedWithCloud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSyncedWithCloud', Sort.asc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      thenByIsSyncedWithCloudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSyncedWithCloud', Sort.desc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy> thenByLogDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logDate', Sort.asc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy> thenByLogDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logDate', Sort.desc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy> thenBySupabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseId', Sort.asc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      thenBySupabaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseId', Sort.desc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      thenByTargetCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetCalories', Sort.asc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      thenByTargetCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetCalories', Sort.desc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      thenByTargetProtein() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetProtein', Sort.asc);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QAfterSortBy>
      thenByTargetProteinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetProtein', Sort.desc);
    });
  }
}

extension LocalDailyLogQueryWhereDistinct
    on QueryBuilder<LocalDailyLog, LocalDailyLog, QDistinct> {
  QueryBuilder<LocalDailyLog, LocalDailyLog, QDistinct>
      distinctByConsumedCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'consumedCalories');
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QDistinct>
      distinctByConsumedCarbs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'consumedCarbs');
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QDistinct>
      distinctByConsumedFats() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'consumedFats');
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QDistinct>
      distinctByConsumedProtein() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'consumedProtein');
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QDistinct>
      distinctByIsSyncedWithCloud() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSyncedWithCloud');
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QDistinct> distinctByLogDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logDate');
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QDistinct> distinctBySupabaseId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supabaseId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QDistinct>
      distinctByTargetCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetCalories');
    });
  }

  QueryBuilder<LocalDailyLog, LocalDailyLog, QDistinct>
      distinctByTargetProtein() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetProtein');
    });
  }
}

extension LocalDailyLogQueryProperty
    on QueryBuilder<LocalDailyLog, LocalDailyLog, QQueryProperty> {
  QueryBuilder<LocalDailyLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LocalDailyLog, double, QQueryOperations>
      consumedCaloriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'consumedCalories');
    });
  }

  QueryBuilder<LocalDailyLog, double, QQueryOperations>
      consumedCarbsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'consumedCarbs');
    });
  }

  QueryBuilder<LocalDailyLog, double, QQueryOperations> consumedFatsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'consumedFats');
    });
  }

  QueryBuilder<LocalDailyLog, double, QQueryOperations>
      consumedProteinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'consumedProtein');
    });
  }

  QueryBuilder<LocalDailyLog, bool, QQueryOperations>
      isSyncedWithCloudProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSyncedWithCloud');
    });
  }

  QueryBuilder<LocalDailyLog, DateTime, QQueryOperations> logDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logDate');
    });
  }

  QueryBuilder<LocalDailyLog, String?, QQueryOperations> supabaseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supabaseId');
    });
  }

  QueryBuilder<LocalDailyLog, double, QQueryOperations>
      targetCaloriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetCalories');
    });
  }

  QueryBuilder<LocalDailyLog, double, QQueryOperations>
      targetProteinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetProtein');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLocalMealCollection on Isar {
  IsarCollection<LocalMeal> get localMeals => this.collection();
}

const LocalMealSchema = CollectionSchema(
  name: r'LocalMeal',
  id: 5489092018042660550,
  properties: {
    r'calories': PropertySchema(
      id: 0,
      name: r'calories',
      type: IsarType.double,
    ),
    r'carbs': PropertySchema(
      id: 1,
      name: r'carbs',
      type: IsarType.double,
    ),
    r'fats': PropertySchema(
      id: 2,
      name: r'fats',
      type: IsarType.double,
    ),
    r'loggedAt': PropertySchema(
      id: 3,
      name: r'loggedAt',
      type: IsarType.dateTime,
    ),
    r'mealType': PropertySchema(
      id: 4,
      name: r'mealType',
      type: IsarType.string,
    ),
    r'protein': PropertySchema(
      id: 5,
      name: r'protein',
      type: IsarType.double,
    ),
    r'supabaseId': PropertySchema(
      id: 6,
      name: r'supabaseId',
      type: IsarType.string,
    )
  },
  estimateSize: _localMealEstimateSize,
  serialize: _localMealSerialize,
  deserialize: _localMealDeserialize,
  deserializeProp: _localMealDeserializeProp,
  idName: r'id',
  indexes: {
    r'supabaseId': IndexSchema(
      id: 2753382765909358918,
      name: r'supabaseId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'supabaseId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'dailyLog': LinkSchema(
      id: -6402821008143803075,
      name: r'dailyLog',
      target: r'LocalDailyLog',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _localMealGetId,
  getLinks: _localMealGetLinks,
  attach: _localMealAttach,
  version: '3.1.0+1',
);

int _localMealEstimateSize(
  LocalMeal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.mealType.length * 3;
  {
    final value = object.supabaseId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _localMealSerialize(
  LocalMeal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.calories);
  writer.writeDouble(offsets[1], object.carbs);
  writer.writeDouble(offsets[2], object.fats);
  writer.writeDateTime(offsets[3], object.loggedAt);
  writer.writeString(offsets[4], object.mealType);
  writer.writeDouble(offsets[5], object.protein);
  writer.writeString(offsets[6], object.supabaseId);
}

LocalMeal _localMealDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocalMeal();
  object.calories = reader.readDouble(offsets[0]);
  object.carbs = reader.readDouble(offsets[1]);
  object.fats = reader.readDouble(offsets[2]);
  object.id = id;
  object.loggedAt = reader.readDateTime(offsets[3]);
  object.mealType = reader.readString(offsets[4]);
  object.protein = reader.readDouble(offsets[5]);
  object.supabaseId = reader.readStringOrNull(offsets[6]);
  return object;
}

P _localMealDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _localMealGetId(LocalMeal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _localMealGetLinks(LocalMeal object) {
  return [object.dailyLog];
}

void _localMealAttach(IsarCollection<dynamic> col, Id id, LocalMeal object) {
  object.id = id;
  object.dailyLog
      .attach(col, col.isar.collection<LocalDailyLog>(), r'dailyLog', id);
}

extension LocalMealQueryWhereSort
    on QueryBuilder<LocalMeal, LocalMeal, QWhere> {
  QueryBuilder<LocalMeal, LocalMeal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LocalMealQueryWhere
    on QueryBuilder<LocalMeal, LocalMeal, QWhereClause> {
  QueryBuilder<LocalMeal, LocalMeal, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterWhereClause> supabaseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'supabaseId',
        value: [null],
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterWhereClause> supabaseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'supabaseId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterWhereClause> supabaseIdEqualTo(
      String? supabaseId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'supabaseId',
        value: [supabaseId],
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterWhereClause> supabaseIdNotEqualTo(
      String? supabaseId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseId',
              lower: [],
              upper: [supabaseId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseId',
              lower: [supabaseId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseId',
              lower: [supabaseId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseId',
              lower: [],
              upper: [supabaseId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension LocalMealQueryFilter
    on QueryBuilder<LocalMeal, LocalMeal, QFilterCondition> {
  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> caloriesEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'calories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> caloriesGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'calories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> caloriesLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'calories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> caloriesBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'calories',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> carbsEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carbs',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> carbsGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'carbs',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> carbsLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'carbs',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> carbsBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'carbs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> fatsEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fats',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> fatsGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fats',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> fatsLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fats',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> fatsBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fats',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> loggedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loggedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> loggedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'loggedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> loggedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'loggedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> loggedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'loggedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> mealTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mealType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> mealTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mealType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> mealTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mealType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> mealTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mealType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> mealTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mealType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> mealTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mealType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> mealTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mealType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> mealTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mealType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> mealTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mealType',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition>
      mealTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mealType',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> proteinEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'protein',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> proteinGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'protein',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> proteinLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'protein',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> proteinBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'protein',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> supabaseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'supabaseId',
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition>
      supabaseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'supabaseId',
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> supabaseIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supabaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition>
      supabaseIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'supabaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> supabaseIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'supabaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> supabaseIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'supabaseId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition>
      supabaseIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'supabaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> supabaseIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'supabaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> supabaseIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'supabaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> supabaseIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'supabaseId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition>
      supabaseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supabaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition>
      supabaseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'supabaseId',
        value: '',
      ));
    });
  }
}

extension LocalMealQueryObject
    on QueryBuilder<LocalMeal, LocalMeal, QFilterCondition> {}

extension LocalMealQueryLinks
    on QueryBuilder<LocalMeal, LocalMeal, QFilterCondition> {
  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> dailyLog(
      FilterQuery<LocalDailyLog> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'dailyLog');
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterFilterCondition> dailyLogIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'dailyLog', 0, true, 0, true);
    });
  }
}

extension LocalMealQuerySortBy on QueryBuilder<LocalMeal, LocalMeal, QSortBy> {
  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> sortByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.asc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> sortByCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.desc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> sortByCarbs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbs', Sort.asc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> sortByCarbsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbs', Sort.desc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> sortByFats() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fats', Sort.asc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> sortByFatsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fats', Sort.desc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> sortByLoggedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loggedAt', Sort.asc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> sortByLoggedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loggedAt', Sort.desc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> sortByMealType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealType', Sort.asc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> sortByMealTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealType', Sort.desc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> sortByProtein() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protein', Sort.asc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> sortByProteinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protein', Sort.desc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> sortBySupabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseId', Sort.asc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> sortBySupabaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseId', Sort.desc);
    });
  }
}

extension LocalMealQuerySortThenBy
    on QueryBuilder<LocalMeal, LocalMeal, QSortThenBy> {
  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> thenByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.asc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> thenByCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.desc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> thenByCarbs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbs', Sort.asc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> thenByCarbsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbs', Sort.desc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> thenByFats() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fats', Sort.asc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> thenByFatsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fats', Sort.desc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> thenByLoggedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loggedAt', Sort.asc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> thenByLoggedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loggedAt', Sort.desc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> thenByMealType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealType', Sort.asc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> thenByMealTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealType', Sort.desc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> thenByProtein() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protein', Sort.asc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> thenByProteinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protein', Sort.desc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> thenBySupabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseId', Sort.asc);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QAfterSortBy> thenBySupabaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseId', Sort.desc);
    });
  }
}

extension LocalMealQueryWhereDistinct
    on QueryBuilder<LocalMeal, LocalMeal, QDistinct> {
  QueryBuilder<LocalMeal, LocalMeal, QDistinct> distinctByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calories');
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QDistinct> distinctByCarbs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'carbs');
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QDistinct> distinctByFats() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fats');
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QDistinct> distinctByLoggedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loggedAt');
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QDistinct> distinctByMealType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mealType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QDistinct> distinctByProtein() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'protein');
    });
  }

  QueryBuilder<LocalMeal, LocalMeal, QDistinct> distinctBySupabaseId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supabaseId', caseSensitive: caseSensitive);
    });
  }
}

extension LocalMealQueryProperty
    on QueryBuilder<LocalMeal, LocalMeal, QQueryProperty> {
  QueryBuilder<LocalMeal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LocalMeal, double, QQueryOperations> caloriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calories');
    });
  }

  QueryBuilder<LocalMeal, double, QQueryOperations> carbsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'carbs');
    });
  }

  QueryBuilder<LocalMeal, double, QQueryOperations> fatsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fats');
    });
  }

  QueryBuilder<LocalMeal, DateTime, QQueryOperations> loggedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loggedAt');
    });
  }

  QueryBuilder<LocalMeal, String, QQueryOperations> mealTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mealType');
    });
  }

  QueryBuilder<LocalMeal, double, QQueryOperations> proteinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'protein');
    });
  }

  QueryBuilder<LocalMeal, String?, QQueryOperations> supabaseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supabaseId');
    });
  }
}
