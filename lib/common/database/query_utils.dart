import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noctur/common/database/where.dart';

class QueryUtils {
  const QueryUtils._();

  static Query createQuery(
      CollectionReference collectionReference, List<Where> where) {
    Query query = collectionReference;
    for (final condition in where) {
      if (condition.equalsTo) {
        query = query.where(
          condition.key,
          isEqualTo: condition.value,
        );
      }
      if (condition.arrayContains) {
        query = query.where(
          condition.value,
          arrayContains: condition.value,
        );
      }
    }
    return query;
  }
}
