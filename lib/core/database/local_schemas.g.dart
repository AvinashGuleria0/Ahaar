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

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLocalUserProfileCollection on Isar {
  IsarCollection<LocalUserProfile> get localUserProfiles => this.collection();
}

const LocalUserProfileSchema = CollectionSchema(
  name: r'LocalUserProfile',
  id: -161605424268665818,
  properties: {
    r'dietPreference': PropertySchema(
      id: 0,
      name: r'dietPreference',
      type: IsarType.string,
    ),
    r'goal': PropertySchema(
      id: 1,
      name: r'goal',
      type: IsarType.string,
    ),
    r'heightCm': PropertySchema(
      id: 2,
      name: r'heightCm',
      type: IsarType.double,
    ),
    r'isOnboardingComplete': PropertySchema(
      id: 3,
      name: r'isOnboardingComplete',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'targetCalories': PropertySchema(
      id: 5,
      name: r'targetCalories',
      type: IsarType.long,
    ),
    r'targetCarbsG': PropertySchema(
      id: 6,
      name: r'targetCarbsG',
      type: IsarType.long,
    ),
    r'targetFatsG': PropertySchema(
      id: 7,
      name: r'targetFatsG',
      type: IsarType.long,
    ),
    r'targetProteinG': PropertySchema(
      id: 8,
      name: r'targetProteinG',
      type: IsarType.long,
    ),
    r'targetWaterMl': PropertySchema(
      id: 9,
      name: r'targetWaterMl',
      type: IsarType.long,
    ),
    r'weightKg': PropertySchema(
      id: 10,
      name: r'weightKg',
      type: IsarType.double,
    )
  },
  estimateSize: _localUserProfileEstimateSize,
  serialize: _localUserProfileSerialize,
  deserialize: _localUserProfileDeserialize,
  deserializeProp: _localUserProfileDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _localUserProfileGetId,
  getLinks: _localUserProfileGetLinks,
  attach: _localUserProfileAttach,
  version: '3.1.0+1',
);

int _localUserProfileEstimateSize(
  LocalUserProfile object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.dietPreference;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.goal;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _localUserProfileSerialize(
  LocalUserProfile object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.dietPreference);
  writer.writeString(offsets[1], object.goal);
  writer.writeDouble(offsets[2], object.heightCm);
  writer.writeBool(offsets[3], object.isOnboardingComplete);
  writer.writeString(offsets[4], object.name);
  writer.writeLong(offsets[5], object.targetCalories);
  writer.writeLong(offsets[6], object.targetCarbsG);
  writer.writeLong(offsets[7], object.targetFatsG);
  writer.writeLong(offsets[8], object.targetProteinG);
  writer.writeLong(offsets[9], object.targetWaterMl);
  writer.writeDouble(offsets[10], object.weightKg);
}

LocalUserProfile _localUserProfileDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocalUserProfile();
  object.dietPreference = reader.readStringOrNull(offsets[0]);
  object.goal = reader.readStringOrNull(offsets[1]);
  object.heightCm = reader.readDoubleOrNull(offsets[2]);
  object.id = id;
  object.isOnboardingComplete = reader.readBool(offsets[3]);
  object.name = reader.readStringOrNull(offsets[4]);
  object.targetCalories = reader.readLongOrNull(offsets[5]);
  object.targetCarbsG = reader.readLongOrNull(offsets[6]);
  object.targetFatsG = reader.readLongOrNull(offsets[7]);
  object.targetProteinG = reader.readLongOrNull(offsets[8]);
  object.targetWaterMl = reader.readLongOrNull(offsets[9]);
  object.weightKg = reader.readDoubleOrNull(offsets[10]);
  return object;
}

P _localUserProfileDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _localUserProfileGetId(LocalUserProfile object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _localUserProfileGetLinks(LocalUserProfile object) {
  return [];
}

void _localUserProfileAttach(
    IsarCollection<dynamic> col, Id id, LocalUserProfile object) {
  object.id = id;
}

extension LocalUserProfileQueryWhereSort
    on QueryBuilder<LocalUserProfile, LocalUserProfile, QWhere> {
  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LocalUserProfileQueryWhere
    on QueryBuilder<LocalUserProfile, LocalUserProfile, QWhereClause> {
  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterWhereClause> idBetween(
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
}

extension LocalUserProfileQueryFilter
    on QueryBuilder<LocalUserProfile, LocalUserProfile, QFilterCondition> {
  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      dietPreferenceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dietPreference',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      dietPreferenceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dietPreference',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      dietPreferenceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dietPreference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      dietPreferenceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dietPreference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      dietPreferenceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dietPreference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      dietPreferenceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dietPreference',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      dietPreferenceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dietPreference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      dietPreferenceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dietPreference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      dietPreferenceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dietPreference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      dietPreferenceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dietPreference',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      dietPreferenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dietPreference',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      dietPreferenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dietPreference',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      goalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'goal',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      goalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'goal',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      goalEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      goalGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'goal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      goalLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'goal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      goalBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'goal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      goalStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'goal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      goalEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'goal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      goalContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'goal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      goalMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'goal',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      goalIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goal',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      goalIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'goal',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      heightCmIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'heightCm',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      heightCmIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'heightCm',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      heightCmEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'heightCm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      heightCmGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'heightCm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      heightCmLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'heightCm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      heightCmBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'heightCm',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
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

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      isOnboardingCompleteEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isOnboardingComplete',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetCaloriesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'targetCalories',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetCaloriesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'targetCalories',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetCaloriesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetCalories',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetCaloriesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetCalories',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetCaloriesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetCalories',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetCaloriesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetCalories',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetCarbsGIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'targetCarbsG',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetCarbsGIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'targetCarbsG',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetCarbsGEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetCarbsG',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetCarbsGGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetCarbsG',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetCarbsGLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetCarbsG',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetCarbsGBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetCarbsG',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetFatsGIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'targetFatsG',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetFatsGIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'targetFatsG',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetFatsGEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetFatsG',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetFatsGGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetFatsG',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetFatsGLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetFatsG',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetFatsGBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetFatsG',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetProteinGIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'targetProteinG',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetProteinGIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'targetProteinG',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetProteinGEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetProteinG',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetProteinGGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetProteinG',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetProteinGLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetProteinG',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetProteinGBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetProteinG',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetWaterMlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'targetWaterMl',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetWaterMlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'targetWaterMl',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetWaterMlEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetWaterMl',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetWaterMlGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetWaterMl',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetWaterMlLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetWaterMl',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      targetWaterMlBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetWaterMl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      weightKgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weightKg',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      weightKgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weightKg',
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      weightKgEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weightKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      weightKgGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weightKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      weightKgLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weightKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterFilterCondition>
      weightKgBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weightKg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension LocalUserProfileQueryObject
    on QueryBuilder<LocalUserProfile, LocalUserProfile, QFilterCondition> {}

extension LocalUserProfileQueryLinks
    on QueryBuilder<LocalUserProfile, LocalUserProfile, QFilterCondition> {}

extension LocalUserProfileQuerySortBy
    on QueryBuilder<LocalUserProfile, LocalUserProfile, QSortBy> {
  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      sortByDietPreference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dietPreference', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      sortByDietPreferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dietPreference', Sort.desc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy> sortByGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goal', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      sortByGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goal', Sort.desc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      sortByHeightCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightCm', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      sortByHeightCmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightCm', Sort.desc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      sortByIsOnboardingComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOnboardingComplete', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      sortByIsOnboardingCompleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOnboardingComplete', Sort.desc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      sortByTargetCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetCalories', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      sortByTargetCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetCalories', Sort.desc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      sortByTargetCarbsG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetCarbsG', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      sortByTargetCarbsGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetCarbsG', Sort.desc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      sortByTargetFatsG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetFatsG', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      sortByTargetFatsGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetFatsG', Sort.desc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      sortByTargetProteinG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetProteinG', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      sortByTargetProteinGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetProteinG', Sort.desc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      sortByTargetWaterMl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetWaterMl', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      sortByTargetWaterMlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetWaterMl', Sort.desc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      sortByWeightKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightKg', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      sortByWeightKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightKg', Sort.desc);
    });
  }
}

extension LocalUserProfileQuerySortThenBy
    on QueryBuilder<LocalUserProfile, LocalUserProfile, QSortThenBy> {
  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      thenByDietPreference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dietPreference', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      thenByDietPreferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dietPreference', Sort.desc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy> thenByGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goal', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      thenByGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goal', Sort.desc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      thenByHeightCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightCm', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      thenByHeightCmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightCm', Sort.desc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      thenByIsOnboardingComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOnboardingComplete', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      thenByIsOnboardingCompleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOnboardingComplete', Sort.desc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      thenByTargetCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetCalories', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      thenByTargetCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetCalories', Sort.desc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      thenByTargetCarbsG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetCarbsG', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      thenByTargetCarbsGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetCarbsG', Sort.desc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      thenByTargetFatsG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetFatsG', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      thenByTargetFatsGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetFatsG', Sort.desc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      thenByTargetProteinG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetProteinG', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      thenByTargetProteinGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetProteinG', Sort.desc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      thenByTargetWaterMl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetWaterMl', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      thenByTargetWaterMlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetWaterMl', Sort.desc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      thenByWeightKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightKg', Sort.asc);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QAfterSortBy>
      thenByWeightKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightKg', Sort.desc);
    });
  }
}

extension LocalUserProfileQueryWhereDistinct
    on QueryBuilder<LocalUserProfile, LocalUserProfile, QDistinct> {
  QueryBuilder<LocalUserProfile, LocalUserProfile, QDistinct>
      distinctByDietPreference({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dietPreference',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QDistinct> distinctByGoal(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goal', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QDistinct>
      distinctByHeightCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'heightCm');
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QDistinct>
      distinctByIsOnboardingComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isOnboardingComplete');
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QDistinct>
      distinctByTargetCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetCalories');
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QDistinct>
      distinctByTargetCarbsG() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetCarbsG');
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QDistinct>
      distinctByTargetFatsG() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetFatsG');
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QDistinct>
      distinctByTargetProteinG() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetProteinG');
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QDistinct>
      distinctByTargetWaterMl() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetWaterMl');
    });
  }

  QueryBuilder<LocalUserProfile, LocalUserProfile, QDistinct>
      distinctByWeightKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weightKg');
    });
  }
}

extension LocalUserProfileQueryProperty
    on QueryBuilder<LocalUserProfile, LocalUserProfile, QQueryProperty> {
  QueryBuilder<LocalUserProfile, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LocalUserProfile, String?, QQueryOperations>
      dietPreferenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dietPreference');
    });
  }

  QueryBuilder<LocalUserProfile, String?, QQueryOperations> goalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goal');
    });
  }

  QueryBuilder<LocalUserProfile, double?, QQueryOperations> heightCmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'heightCm');
    });
  }

  QueryBuilder<LocalUserProfile, bool, QQueryOperations>
      isOnboardingCompleteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isOnboardingComplete');
    });
  }

  QueryBuilder<LocalUserProfile, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<LocalUserProfile, int?, QQueryOperations>
      targetCaloriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetCalories');
    });
  }

  QueryBuilder<LocalUserProfile, int?, QQueryOperations>
      targetCarbsGProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetCarbsG');
    });
  }

  QueryBuilder<LocalUserProfile, int?, QQueryOperations> targetFatsGProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetFatsG');
    });
  }

  QueryBuilder<LocalUserProfile, int?, QQueryOperations>
      targetProteinGProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetProteinG');
    });
  }

  QueryBuilder<LocalUserProfile, int?, QQueryOperations>
      targetWaterMlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetWaterMl');
    });
  }

  QueryBuilder<LocalUserProfile, double?, QQueryOperations> weightKgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weightKg');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLocalWorkoutPlanCollection on Isar {
  IsarCollection<LocalWorkoutPlan> get localWorkoutPlans => this.collection();
}

const LocalWorkoutPlanSchema = CollectionSchema(
  name: r'LocalWorkoutPlan',
  id: -8763266079289456845,
  properties: {
    r'daysJson': PropertySchema(
      id: 0,
      name: r'daysJson',
      type: IsarType.stringList,
    ),
    r'planName': PropertySchema(
      id: 1,
      name: r'planName',
      type: IsarType.string,
    )
  },
  estimateSize: _localWorkoutPlanEstimateSize,
  serialize: _localWorkoutPlanSerialize,
  deserialize: _localWorkoutPlanDeserialize,
  deserializeProp: _localWorkoutPlanDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _localWorkoutPlanGetId,
  getLinks: _localWorkoutPlanGetLinks,
  attach: _localWorkoutPlanAttach,
  version: '3.1.0+1',
);

int _localWorkoutPlanEstimateSize(
  LocalWorkoutPlan object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.daysJson.length * 3;
  {
    for (var i = 0; i < object.daysJson.length; i++) {
      final value = object.daysJson[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.planName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _localWorkoutPlanSerialize(
  LocalWorkoutPlan object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.daysJson);
  writer.writeString(offsets[1], object.planName);
}

LocalWorkoutPlan _localWorkoutPlanDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocalWorkoutPlan();
  object.daysJson = reader.readStringList(offsets[0]) ?? [];
  object.id = id;
  object.planName = reader.readStringOrNull(offsets[1]);
  return object;
}

P _localWorkoutPlanDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _localWorkoutPlanGetId(LocalWorkoutPlan object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _localWorkoutPlanGetLinks(LocalWorkoutPlan object) {
  return [];
}

void _localWorkoutPlanAttach(
    IsarCollection<dynamic> col, Id id, LocalWorkoutPlan object) {
  object.id = id;
}

extension LocalWorkoutPlanQueryWhereSort
    on QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QWhere> {
  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LocalWorkoutPlanQueryWhere
    on QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QWhereClause> {
  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterWhereClause> idBetween(
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
}

extension LocalWorkoutPlanQueryFilter
    on QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QFilterCondition> {
  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      daysJsonElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'daysJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      daysJsonElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'daysJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      daysJsonElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'daysJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      daysJsonElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'daysJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      daysJsonElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'daysJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      daysJsonElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'daysJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      daysJsonElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'daysJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      daysJsonElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'daysJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      daysJsonElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'daysJson',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      daysJsonElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'daysJson',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      daysJsonLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'daysJson',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      daysJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'daysJson',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      daysJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'daysJson',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      daysJsonLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'daysJson',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      daysJsonLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'daysJson',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      daysJsonLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'daysJson',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
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

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      planNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'planName',
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      planNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'planName',
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      planNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'planName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      planNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'planName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      planNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'planName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      planNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'planName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      planNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'planName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      planNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'planName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      planNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'planName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      planNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'planName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      planNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'planName',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterFilterCondition>
      planNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'planName',
        value: '',
      ));
    });
  }
}

extension LocalWorkoutPlanQueryObject
    on QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QFilterCondition> {}

extension LocalWorkoutPlanQueryLinks
    on QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QFilterCondition> {}

extension LocalWorkoutPlanQuerySortBy
    on QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QSortBy> {
  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterSortBy>
      sortByPlanName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planName', Sort.asc);
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterSortBy>
      sortByPlanNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planName', Sort.desc);
    });
  }
}

extension LocalWorkoutPlanQuerySortThenBy
    on QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QSortThenBy> {
  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterSortBy>
      thenByPlanName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planName', Sort.asc);
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QAfterSortBy>
      thenByPlanNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planName', Sort.desc);
    });
  }
}

extension LocalWorkoutPlanQueryWhereDistinct
    on QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QDistinct> {
  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QDistinct>
      distinctByDaysJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'daysJson');
    });
  }

  QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QDistinct>
      distinctByPlanName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'planName', caseSensitive: caseSensitive);
    });
  }
}

extension LocalWorkoutPlanQueryProperty
    on QueryBuilder<LocalWorkoutPlan, LocalWorkoutPlan, QQueryProperty> {
  QueryBuilder<LocalWorkoutPlan, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LocalWorkoutPlan, List<String>, QQueryOperations>
      daysJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'daysJson');
    });
  }

  QueryBuilder<LocalWorkoutPlan, String?, QQueryOperations> planNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'planName');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLocalExerciseLogCollection on Isar {
  IsarCollection<LocalExerciseLog> get localExerciseLogs => this.collection();
}

const LocalExerciseLogSchema = CollectionSchema(
  name: r'LocalExerciseLog',
  id: -9125427882515993321,
  properties: {
    r'completedSetsJson': PropertySchema(
      id: 0,
      name: r'completedSetsJson',
      type: IsarType.stringList,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'exerciseName': PropertySchema(
      id: 2,
      name: r'exerciseName',
      type: IsarType.string,
    ),
    r'isSyncedWithCloud': PropertySchema(
      id: 3,
      name: r'isSyncedWithCloud',
      type: IsarType.bool,
    ),
    r'supabaseId': PropertySchema(
      id: 4,
      name: r'supabaseId',
      type: IsarType.string,
    )
  },
  estimateSize: _localExerciseLogEstimateSize,
  serialize: _localExerciseLogSerialize,
  deserialize: _localExerciseLogDeserialize,
  deserializeProp: _localExerciseLogDeserializeProp,
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
    r'date': IndexSchema(
      id: -7552997827385218417,
      name: r'date',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'date',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'dailyLog': LinkSchema(
      id: 4660126339051087717,
      name: r'dailyLog',
      target: r'LocalDailyLog',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _localExerciseLogGetId,
  getLinks: _localExerciseLogGetLinks,
  attach: _localExerciseLogAttach,
  version: '3.1.0+1',
);

int _localExerciseLogEstimateSize(
  LocalExerciseLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.completedSetsJson.length * 3;
  {
    for (var i = 0; i < object.completedSetsJson.length; i++) {
      final value = object.completedSetsJson[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.exerciseName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.supabaseId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _localExerciseLogSerialize(
  LocalExerciseLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.completedSetsJson);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeString(offsets[2], object.exerciseName);
  writer.writeBool(offsets[3], object.isSyncedWithCloud);
  writer.writeString(offsets[4], object.supabaseId);
}

LocalExerciseLog _localExerciseLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocalExerciseLog();
  object.completedSetsJson = reader.readStringList(offsets[0]) ?? [];
  object.date = reader.readDateTime(offsets[1]);
  object.exerciseName = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.isSyncedWithCloud = reader.readBool(offsets[3]);
  object.supabaseId = reader.readStringOrNull(offsets[4]);
  return object;
}

P _localExerciseLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _localExerciseLogGetId(LocalExerciseLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _localExerciseLogGetLinks(LocalExerciseLog object) {
  return [object.dailyLog];
}

void _localExerciseLogAttach(
    IsarCollection<dynamic> col, Id id, LocalExerciseLog object) {
  object.id = id;
  object.dailyLog
      .attach(col, col.isar.collection<LocalDailyLog>(), r'dailyLog', id);
}

extension LocalExerciseLogQueryWhereSort
    on QueryBuilder<LocalExerciseLog, LocalExerciseLog, QWhere> {
  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension LocalExerciseLogQueryWhere
    on QueryBuilder<LocalExerciseLog, LocalExerciseLog, QWhereClause> {
  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterWhereClause> idBetween(
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

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterWhereClause>
      supabaseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'supabaseId',
        value: [null],
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterWhereClause>
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

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterWhereClause>
      supabaseIdEqualTo(String? supabaseId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'supabaseId',
        value: [supabaseId],
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterWhereClause>
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

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterWhereClause>
      dateEqualTo(DateTime date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date',
        value: [date],
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterWhereClause>
      dateNotEqualTo(DateTime date) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterWhereClause>
      dateGreaterThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [date],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterWhereClause>
      dateLessThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [],
        upper: [date],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterWhereClause>
      dateBetween(
    DateTime lowerDate,
    DateTime upperDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [lowerDate],
        includeLower: includeLower,
        upper: [upperDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LocalExerciseLogQueryFilter
    on QueryBuilder<LocalExerciseLog, LocalExerciseLog, QFilterCondition> {
  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      completedSetsJsonElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedSetsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      completedSetsJsonElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedSetsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      completedSetsJsonElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedSetsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      completedSetsJsonElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedSetsJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      completedSetsJsonElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'completedSetsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      completedSetsJsonElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'completedSetsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      completedSetsJsonElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'completedSetsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      completedSetsJsonElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'completedSetsJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      completedSetsJsonElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedSetsJson',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      completedSetsJsonElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'completedSetsJson',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      completedSetsJsonLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedSetsJson',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      completedSetsJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedSetsJson',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      completedSetsJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedSetsJson',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      completedSetsJsonLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedSetsJson',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      completedSetsJsonLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedSetsJson',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      completedSetsJsonLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedSetsJson',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      exerciseNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'exerciseName',
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      exerciseNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'exerciseName',
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      exerciseNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      exerciseNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      exerciseNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      exerciseNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exerciseName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      exerciseNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      exerciseNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      exerciseNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      exerciseNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'exerciseName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      exerciseNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exerciseName',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      exerciseNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'exerciseName',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
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

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      isSyncedWithCloudEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSyncedWithCloud',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      supabaseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'supabaseId',
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      supabaseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'supabaseId',
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
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

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
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

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
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

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
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

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
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

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
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

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      supabaseIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'supabaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      supabaseIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'supabaseId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      supabaseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supabaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      supabaseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'supabaseId',
        value: '',
      ));
    });
  }
}

extension LocalExerciseLogQueryObject
    on QueryBuilder<LocalExerciseLog, LocalExerciseLog, QFilterCondition> {}

extension LocalExerciseLogQueryLinks
    on QueryBuilder<LocalExerciseLog, LocalExerciseLog, QFilterCondition> {
  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      dailyLog(FilterQuery<LocalDailyLog> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'dailyLog');
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterFilterCondition>
      dailyLogIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'dailyLog', 0, true, 0, true);
    });
  }
}

extension LocalExerciseLogQuerySortBy
    on QueryBuilder<LocalExerciseLog, LocalExerciseLog, QSortBy> {
  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterSortBy>
      sortByExerciseName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseName', Sort.asc);
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterSortBy>
      sortByExerciseNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseName', Sort.desc);
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterSortBy>
      sortByIsSyncedWithCloud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSyncedWithCloud', Sort.asc);
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterSortBy>
      sortByIsSyncedWithCloudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSyncedWithCloud', Sort.desc);
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterSortBy>
      sortBySupabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseId', Sort.asc);
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterSortBy>
      sortBySupabaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseId', Sort.desc);
    });
  }
}

extension LocalExerciseLogQuerySortThenBy
    on QueryBuilder<LocalExerciseLog, LocalExerciseLog, QSortThenBy> {
  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterSortBy>
      thenByExerciseName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseName', Sort.asc);
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterSortBy>
      thenByExerciseNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseName', Sort.desc);
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterSortBy>
      thenByIsSyncedWithCloud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSyncedWithCloud', Sort.asc);
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterSortBy>
      thenByIsSyncedWithCloudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSyncedWithCloud', Sort.desc);
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterSortBy>
      thenBySupabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseId', Sort.asc);
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QAfterSortBy>
      thenBySupabaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseId', Sort.desc);
    });
  }
}

extension LocalExerciseLogQueryWhereDistinct
    on QueryBuilder<LocalExerciseLog, LocalExerciseLog, QDistinct> {
  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QDistinct>
      distinctByCompletedSetsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedSetsJson');
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QDistinct>
      distinctByExerciseName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exerciseName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QDistinct>
      distinctByIsSyncedWithCloud() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSyncedWithCloud');
    });
  }

  QueryBuilder<LocalExerciseLog, LocalExerciseLog, QDistinct>
      distinctBySupabaseId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supabaseId', caseSensitive: caseSensitive);
    });
  }
}

extension LocalExerciseLogQueryProperty
    on QueryBuilder<LocalExerciseLog, LocalExerciseLog, QQueryProperty> {
  QueryBuilder<LocalExerciseLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LocalExerciseLog, List<String>, QQueryOperations>
      completedSetsJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedSetsJson');
    });
  }

  QueryBuilder<LocalExerciseLog, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<LocalExerciseLog, String?, QQueryOperations>
      exerciseNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exerciseName');
    });
  }

  QueryBuilder<LocalExerciseLog, bool, QQueryOperations>
      isSyncedWithCloudProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSyncedWithCloud');
    });
  }

  QueryBuilder<LocalExerciseLog, String?, QQueryOperations>
      supabaseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supabaseId');
    });
  }
}
