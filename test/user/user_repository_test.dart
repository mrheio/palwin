import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noctur/common/database/firestore_service.dart';
import 'package:noctur/user/user.dart';
import 'package:noctur/user/user_repository.dart';

void main() {
  FakeFirebaseFirestore firestore = FakeFirebaseFirestore();
  UserRepository userRepository =
      UserRepository(FirestoreService(firestore, 'users'));

  test('Given a user - when add is called - it should add the user to db',
      () async {
    final user = User(
        id: '1',
        email: 'test1@gmail.com',
        username: 'test1',
        roles: const {'admin': true});

    await userRepository.add(user);

    final doc = await firestore.collection('users').doc('1').get();

    expect(User.fromMap(doc.data()!), user);
  });
}
