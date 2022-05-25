import 'package:noctur/common/database/base_service.dart';
import 'package:noctur/user/user.dart';
import 'package:noctur/user/user_repository.dart';

class UserService extends BaseService<User, UserRepository> {
  const UserService(UserRepository userRepository) : super(userRepository);

  Stream<List<User>> getByIds$(List<String> ids) {
    return repository.getByIds$(ids);
  }
}
