import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palwin/common/database/repository_factory.dart';

import 'storage/firebase_storage_service.dart';

final firebaseAuthProvider = Provider((ref) {
  return FirebaseAuth.instance;
});

final firestoreProvider = Provider((ref) {
  return FirebaseFirestore.instance;
});

final firestoreRepositoryFactoryProvider = Provider((ref) {
  return FirestoreRepositoryFactory(ref.read(firestoreProvider));
});

final firebaseStorageProvider = Provider((ref) {
  return FirebaseStorage.instance;
});

final firebaseStorageServiceProvider = Provider((ref) {
  final firebaseStorage = ref.read(firebaseStorageProvider);
  return FirebaseStorageService(firebaseStorage);
});
