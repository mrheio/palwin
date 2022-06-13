import 'package:noctur/common/database/query_helpers.dart';
import 'package:optional/optional.dart';

abstract class BaseRepository<T> {
  Future<List<T>> getAll();
  Stream<List<T>> getAll$();
  Future<Optional<T>> getById(String id);
  Stream<Optional<T>> getById$(String id);
  Future<List<T>> getWhere(QueryFilter filter);
  Stream<List<T>> getWhere$(QueryFilter filter);
  Future<void> add(T data);
  Future<void> deleteAll();
  Future<void> deleteById(String id);
  Future<void> deleteWhere(QueryFilter filter);
  Future<void> update(T newData);
}
