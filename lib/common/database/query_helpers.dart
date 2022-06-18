import 'package:cloud_firestore/cloud_firestore.dart';

abstract class QueryCondition {
  const QueryCondition();

  Query addToQuery(Query query);
}

enum OrderRule { asc, desc }

class OrderCondition extends QueryCondition {
  final String key;
  final OrderRule rule;

  OrderCondition(this.key, this.rule);

  @override
  Query<Object?> addToQuery(Query query) {
    return query.orderBy(key, descending: rule == OrderRule.desc);
  }
}

enum WhereRule {
  isEqualTo,
  arrayContains,
  whereIn,
  whereNotIn,
  isGreaterThan,
  isLessThan,
  hasInSubcollection,
}

class WhereCondition extends QueryCondition {
  final String key;
  final WhereRule rule;
  final dynamic value;

  WhereCondition(this.key, this.rule, this.value);

  @override
  Query<Object?> addToQuery(Query<Object?> query) {
    switch (rule) {
      case WhereRule.isEqualTo:
        return query.where(key, isEqualTo: value);
      case WhereRule.arrayContains:
        return query.where(key, arrayContains: value);
      case WhereRule.whereIn:
        return query.where(key, whereIn: value);
      case WhereRule.whereNotIn:
        return query.where(key, whereNotIn: value);
      case WhereRule.isGreaterThan:
        return query.where(key, isGreaterThan: value);
      case WhereRule.isLessThan:
        return query.where(key, isLessThan: value);
      default:
        throw UnimplementedError();
    }
  }
}

class QueryFilter {
  final List<QueryCondition> conditions;

  QueryFilter([this.conditions = const []]);

  QueryFilter _addCondition(QueryCondition condition) {
    return QueryFilter([...conditions, condition]);
  }

  QueryFilter _addWhereCondition({
    required String key,
    required WhereRule rule,
    required dynamic value,
  }) {
    return _addCondition(WhereCondition(key, rule, value));
  }

  QueryFilter equalsTo({required String key, required dynamic value}) {
    return _addWhereCondition(
        key: key, rule: WhereRule.isEqualTo, value: value);
  }

  QueryFilter arrayContains({required String key, required dynamic value}) {
    return _addWhereCondition(
        key: key, rule: WhereRule.arrayContains, value: value);
  }

  QueryFilter whereIn({required String key, required dynamic value}) {
    return _addWhereCondition(key: key, rule: WhereRule.whereIn, value: value);
  }

  QueryFilter whereNotIn({required String key, required dynamic value}) {
    return _addWhereCondition(
        key: key, rule: WhereRule.whereNotIn, value: value);
  }

  QueryFilter isGreaterThan({required String key, required dynamic value}) {
    return _addWhereCondition(
        key: key, rule: WhereRule.isGreaterThan, value: value);
  }

  QueryFilter isLessThan({required String key, required dynamic value}) {
    return _addWhereCondition(
        key: key, rule: WhereRule.isLessThan, value: value);
  }

  QueryFilter _addOrderCondition({
    required String key,
    required OrderRule rule,
  }) {
    return _addCondition(OrderCondition(key, rule));
  }

  QueryFilter orderAsc(String key) {
    return _addOrderCondition(key: key, rule: OrderRule.asc);
  }

  QueryFilter orderDesc(String key) {
    return _addOrderCondition(key: key, rule: OrderRule.desc);
  }

  Query createFirestoreQuery(Query query) {
    Query _query = query;
    for (final condition in conditions) {
      _query = condition.addToQuery(_query);
    }
    return _query;
  }
}
