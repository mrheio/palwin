import 'package:noctur/auth/auth_service.dart';
import 'package:optional/optional.dart';
import 'package:rxdart/rxdart.dart';

import '../common/database/base_service.dart';
import '../common/database/query_filters.dart';
import '../user/user_repository.dart';
import 'message.dart';
import 'message_repository.dart';

class MessageService extends BaseService<Message, MessageRepository> {
  final UserRepository _userRepository;
  final AuthService _authService;

  MessageService(
      MessageRepository repository, this._userRepository, this._authService)
      : super(repository);

  Future<void> sendMessage(String text) async {
    final user = (await _authService.getLoggedUser())!;
    final message = Message(
      message: text,
      uid: user.id,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    await add(message);
  }

  @override
  Stream<List<Message>> getAll$() {
    return repository.getWhere$(
        const [OrderBy(key: 'createdAt', rule: OrderRule.desc)]).switchMap(
      (value) async* {
        if (value.isNotEmpty) {
          yield* CombineLatestStream.list(value.map((e) {
            final user$ = _userRepository.getById$(e.uid);
            return user$
                .map((event) => e.copyWith(user: Optional.ofNullable(event)));
          }));
        }
        yield [];
      },
    );
  }
}
