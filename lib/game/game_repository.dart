import '../common/database/base_repository.dart';
import '../common/database/database_service.dart';
import 'game.dart';

class GameRepository extends BaseRepository<Game> {
  const GameRepository(DatabaseService<Game> databaseService)
      : super(databaseService);

  Future<Game?> getByName(String name) {
    return databaseService.getById(Game.toId(name));
  }
}
