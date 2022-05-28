import '../common/database/base_service.dart';
import '../common/errors/resource_already_exists.dart';
import '../team/team_repository.dart';
import 'game.dart';
import 'game_repository.dart';

class GameService extends BaseService<Game, GameRepository> {
  final TeamRepository _teamRepository;

  const GameService(GameRepository gameRepository, this._teamRepository)
      : super(gameRepository);

  @override
  Future<void> add(Game data) async {
    final game = await repository.getById(data.id);
    if (game != null) {
      throw GameAlreadyExists(data);
    }

    return super.add(data);
  }

  @override
  Future<void> deleteById(String id) async {
    await _teamRepository.deleteByGame(Game.toName(id));
    await repository.deleteById(id);
  }
}
