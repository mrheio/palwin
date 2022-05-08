import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noctur/common/database/database_service.dart';
import 'package:noctur/common/database/query_utils.dart';
import 'package:noctur/common/database/serializable.dart';
import 'package:noctur/common/database/where.dart';

class FirestoreService<T extends Serializable> implements DatabaseService<T> {
  final CollectionReference _collectionRef;

  FirestoreService(FirebaseFirestore firestore, String collectionPath)
      : _collectionRef = firestore.collection(collectionPath);

  @override
  Future<void> add(T data) async {
    await _collectionRef.doc(data.id).set(data.toMap());
  }

  @override
  Future<void> deleteById(String id) async {
    await _collectionRef.doc(id).delete();
  }

  @override
  Future<void> deleteWhere(List<Where> where) async {
    final query = QueryUtils.createQuery(_collectionRef, where);
    final qs = await query.get();
    for (final doc in qs.docs) {
      await doc.reference.delete();
    }
  }

  @override
  Future<void> update(String id, T newData) async {
    await _collectionRef.doc(id).update(newData.toMap());
  }

  @override
  Future<List<T>> getAll() async {
    final qs = await _collectionRef.get();
    if (qs.docs.isEmpty) {
      return <T>[];
    }
    final List<T> result =
        qs.docs.map(Serializable.deserializeDocument<T>).toList();
    return result;
  }

  @override
  Stream<List<T>> getAll$() {
    final qs$ = _collectionRef.snapshots();
    final result$ = qs$.map((event) {
      final docs = event.docs;
      if (docs.isEmpty) {
        return <T>[];
      }
      return docs.map(Serializable.deserializeDocument<T>).toList();
    });
    return result$;
  }

  @override
  Future<T?> getById(String id) async {
    final docRef = await _collectionRef.doc(id).get();
    if (docRef.exists) {
      return Serializable.deserializeDocument<T>(docRef);
    }
    return null;
  }

  @override
  Stream<T?> getById$(String id) {
    final docRef$ = _collectionRef.doc(id).snapshots();
    final result$ = docRef$.map((doc) {
      if (doc.exists) {
        return Serializable.deserializeDocument<T>(doc);
      }
      return null;
    });
    return result$;
  }

  @override
  Future<List<T>> getWhere(List<Where> where) async {
    final query = QueryUtils.createQuery(_collectionRef, where);
    final qs = await query.get();
    if (qs.docs.isEmpty) {
      return <T>[];
    }
    final result = qs.docs.map(Serializable.deserializeDocument<T>).toList();
    return result;
  }

  @override
  Stream<List<T>> getWhere$(List<Where> where) {
    final query = QueryUtils.createQuery(_collectionRef, where);
    final qs$ = query.snapshots();
    final result$ = qs$.map((event) {
      final docs = event.docs;
      if (docs.isEmpty) {
        return <T>[];
      }
      return docs.map(Serializable.deserializeDocument<T>).toList();
    });
    return result$;
  }
}
