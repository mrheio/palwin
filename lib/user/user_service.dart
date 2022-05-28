import '../common/database/base_service.dart';
import 'user.dart';
import 'user_repository.dart';

class UserService extends BaseService<User, UserRepository> {
  const UserService(UserRepository userRepository) : super(userRepository);

  Stream<List<User>> getByIds$(List<String> ids) {
    return repository.getByIds$(ids);
  }
}
