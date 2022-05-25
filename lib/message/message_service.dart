import 'package:noctur/common/database/base_service.dart';
import 'package:noctur/common/database/query_filters.dart';
import 'package:noctur/message/message_repository.dart';
import 'package:noctur/user/user_repository.dart';
import 'package:optional/optional.dart';
import 'package:rxdart/rxdart.dart';

import 'message.dart';

class MessageService extends BaseService<Message, MessageRepository> {
  final UserRepository _userRepository;

  MessageService(MessageRepository repository, this._userRepository)
      : super(repository);

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
