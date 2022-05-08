import 'package:noctur/common/database/base_service.dart';
import 'package:noctur/user/user.dart';
import 'package:noctur/user/user_repository.dart';

class UserService extends BaseService<User> {
  const UserService(UserRepository userRepository) : super(userRepository);
}
