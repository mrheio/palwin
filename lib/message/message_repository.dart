import '../common/database/base_repository.dart';
import '../common/database/database_service.dart';
import 'message.dart';

class MessageRepository extends BaseRepository<Message> {
  MessageRepository(DatabaseService<Message> databaseService)
      : super(databaseService);
}
