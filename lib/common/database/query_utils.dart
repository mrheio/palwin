import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noctur/common/database/query_filters.dart';

class QueryUtils {
  const QueryUtils._();

  static Query createQuery(
      CollectionReference collectionReference, List<QueryFilter> where) {
    Query query = collectionReference;
    for (final condition in where) {
      if (condition is Where) {
        if (condition.equalsTo) {
          query = query.where(
            condition.key,
            isEqualTo: condition.value,
          );
        }
        if (condition.arrayContains) {
          query = query.where(
            condition.key,
            arrayContains: condition.value,
          );
        }
        if (condition.whereIn) {
          query = query.where(condition.key, whereIn: condition.value);
        }
      }
      if (condition is OrderBy) {
        query = query.orderBy(condition.key, descending: condition.desc);
      }
    }
    return query;
  }
}
