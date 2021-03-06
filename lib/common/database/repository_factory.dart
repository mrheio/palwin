import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:palwin/common/database/base_repository.dart';
import 'package:palwin/common/database/serializable.dart';
import 'package:palwin/game/logic/logic.dart';
import 'package:palwin/team/logic/logic.dart';
import 'package:palwin/user/logic/logic.dart';

import 'firestore_repository.dart';

typedef CollectionReferenceHandler = CollectionReference Function(String);

CollectionReferenceHandler _getCollectionFromRoot(
        FirebaseFirestore firestore) =>
    (String collectionPath) => firestore.collection(collectionPath);

CollectionReferenceHandler _getCollectionFromDocument(DocumentReference doc) =>
    (String collectionPath) => doc.collection(collectionPath);

class FirestoreRepositoryFactory {
  final CollectionReferenceHandler getCollectionReference;

  static final _collectionsMap = {
    SimpleUser: 'members',
    ComplexUser: 'users',
    Friend: 'friends',
    Team: 'teams',
    Game: 'games',
    Message: 'messages',
  };

  FirestoreRepositoryFactory(FirebaseFirestore firestore)
      : getCollectionReference = _getCollectionFromRoot(firestore);

  FirestoreRepositoryFactory._fromDocument(DocumentReference doc)
      : getCollectionReference = _getCollectionFromDocument(doc);

  FirestoreRepositoryFactory fromDocument<T>(String docId) {
    final collectionName = _collectionsMap[T]!;
    final doc = getCollectionReference(collectionName).doc(docId);
    return FirestoreRepositoryFactory._fromDocument(doc);
  }

  BaseRepository<T> getRepository<T extends Serializable>() {
    final collectionName = _collectionsMap[T]!;
    return FirestoreRepository<T>(getCollectionReference(collectionName));
  }
}
