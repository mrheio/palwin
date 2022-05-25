import 'package:noctur/common/database/query_filters.dart';

abstract class DatabaseService<T> {
  const DatabaseService();

  Future<void> add(T data);
  Future<void> deleteById(String id);
  Future<void> deleteWhere(List<Where> filters);
  Future<void> update(String id, T newData);
  Future<List<T>> getAll();
  Stream<List<T>> getAll$();
  Future<T?> getById(String id);
  Stream<T?> getById$(String id);
  Future<List<T>> getWhere(List<QueryFilter> filters);
  Stream<List<T>> getWhere$(List<QueryFilter> filters);
}
