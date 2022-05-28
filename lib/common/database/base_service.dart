import 'base_repository.dart';
import 'query_filters.dart';

abstract class BaseService<T, G extends BaseRepository<T>> {
  final G repository;

  const BaseService(this.repository);

  Future<void> add(T data) async {
    repository.add(data);
  }

  Future<void> deleteById(String id) async {
    repository.deleteById(id);
  }

  Future<void> deleteWhere(List<Where> where) async {
    repository.deleteWhere(where);
  }

  Future<void> update(String id, T newData) async {
    repository.update(id, newData);
  }

  Future<List<T>> getAll() {
    return repository.getAll();
  }

  Stream<List<T>> getAll$() {
    return repository.getAll$();
  }

  Future<T?> getById(String id) {
    return repository.getById(id);
  }

  Stream<T?> getById$(String id) {
    return repository.getById$(id);
  }

  Future<List<T>> getWhere(List<QueryFilter> filters) {
    return repository.getWhere(filters);
  }

  Stream<List<T>> getWhere$(List<QueryFilter> filters) {
    return repository.getWhere$(filters);
  }
}
