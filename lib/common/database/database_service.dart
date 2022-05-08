import 'package:noctur/common/database/where.dart';

abstract class DatabaseService<T> {
  const DatabaseService();

  Future<void> add(T data);
  Future<void> deleteById(String id);
  Future<void> deleteWhere(List<Where> where);
  Future<void> update(String id, T newData);
  Future<List<T>> getAll();
  Stream<List<T>> getAll$();
  Future<T?> getById(String id);
  Stream<T?> getById$(String id);
  Future<List<T>> getWhere(List<Where> where);
  Stream<List<T>> getWhere$(List<Where> where);
}
