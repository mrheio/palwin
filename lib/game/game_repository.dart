import 'package:noctur/common/database/base_repository.dart';
import 'package:noctur/common/database/database_service.dart';
import 'package:noctur/game/game.dart';

class GameRepository extends BaseRepository<Game> {
  const GameRepository(DatabaseService<Game> databaseService)
      : super(databaseService);
}
