import 'package:noctur/common/database/base_repository.dart';
import 'package:noctur/common/database/where.dart';

abstract class BaseService<T> {
  final BaseRepository<T> repository;

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

  Future<List<T>> getWhere(List<Where> where) {
    return repository.getWhere(where);
  }

  Stream<List<T>> getWhere$(List<Where> where) {
    return repository.getWhere$(where);
  }
}
