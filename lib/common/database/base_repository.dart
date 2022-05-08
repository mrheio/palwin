import 'package:noctur/common/database/database_service.dart';
import 'package:noctur/common/database/where.dart';

abstract class BaseRepository<T> {
  final DatabaseService<T> databaseService;

  const BaseRepository(this.databaseService);

  Future<void> add(T data) async {
    databaseService.add(data);
  }

  Future<void> deleteById(String id) async {
    databaseService.deleteById(id);
  }

  Future<void> deleteWhere(List<Where> where) async {
    databaseService.deleteWhere(where);
  }

  Future<void> update(String id, T newData) async {
    databaseService.update(id, newData);
  }

  Future<List<T>> getAll() {
    return databaseService.getAll();
  }

  Stream<List<T>> getAll$() {
    return databaseService.getAll$();
  }

  Future<T?> getById(String id) {
    return databaseService.getById(id);
  }

  Stream<T?> getById$(String id) {
    return databaseService.getById$(id);
  }

  Future<List<T>> getWhere(List<Where> where) {
    return databaseService.getWhere(where);
  }

  Stream<List<T>> getWhere$(List<Where> where) {
    return databaseService.getWhere$(where);
  }
}