import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optional/optional.dart';
import 'package:palwin/common/database/base_repository.dart';
import 'package:palwin/common/database/query_helpers.dart';
import 'package:palwin/common/database/serializable.dart';
import 'package:palwin/common/exceptions/resource_already_exists.dart';

class FirestoreRepository<T extends Serializable> implements BaseRepository<T> {
  final CollectionReference _collection;

  FirestoreRepository(CollectionReference collection)
      : _collection = collection;

  @override
  Future<List<T>> getAll() async {
    final res = await _collection.get();
    return res.docs.map((e) => Serializable.deserialize<T>(e)).toList();
  }

  @override
  Stream<List<T>> getAll$() {
    final res$ = _collection.snapshots();
    return res$.map((event) =>
        event.docs.map((e) => Serializable.deserialize<T>(e)).toList());
  }

  @override
  Future<Optional<T>> getById(String id) async {
    final res = await _collection.doc(id).get();
    return res.exists
        ? Optional.of(Serializable.deserialize<T>(res))
        : const Optional.empty();
  }

  @override
  Stream<Optional<T>> getById$(String id) {
    final res$ = _collection.doc(id).snapshots();
    return res$.map((event) {
      return event.exists
          ? Optional.of(Serializable.deserialize<T>(event))
          : const Optional.empty();
    });
  }

  @override
  Future<List<T>> getWhere(QueryFilter filter) async {
    final query = filter.createFirestoreQuery(_collection);
    final res = await query.get();
    return res.docs.map((e) => Serializable.deserialize<T>(e)).toList();
  }

  @override
  Stream<List<T>> getWhere$(QueryFilter filter) {
    final query = filter.createFirestoreQuery(_collection);
    final res$ = query.snapshots();
    return res$.map((event) =>
        event.docs.map((e) => Serializable.deserialize<T>(e)).toList());
  }

  @override
  Future<void> add(T data) async {
    var aux = data;

    if (aux.id.isEmpty) {
      final docRef = _collection.doc();
      aux = aux.copyWith(id: docRef.id);
    }

    final res = await _collection.doc(aux.id).get();
    if (res.exists) {
      throw const ResourceAlreadyExists();
    }

    await _collection.doc(aux.id).set(aux.toJson());
  }

  @override
  Future<void> deleteAll() async {
    final res = await _collection.get();
    for (final doc in res.docs) {
      await doc.reference.delete();
    }
  }

  @override
  Future<void> deleteById(String id) async {
    await _collection.doc(id).delete();
  }

  @override
  Future<void> deleteWhere(QueryFilter filter) async {
    final query = filter.createFirestoreQuery(_collection);
    final res = await query.get();
    for (final doc in res.docs) {
      await doc.reference.delete();
    }
  }

  @override
  Future<void> update(T newData) async {
    await _collection.doc(newData.id).set(newData.toJson());
  }
}
