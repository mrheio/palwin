import 'package:noctur/common/database/base_service.dart';
import 'package:noctur/game/game.dart';
import 'package:noctur/game/game_repository.dart';
import 'package:noctur/team/team_repository.dart';

class GameService extends BaseService<Game, GameRepository> {
  final TeamRepository _teamRepository;

  const GameService(GameRepository gameRepository, this._teamRepository)
      : super(gameRepository);

  @override
  Future<void> deleteById(String id) async {
    await _teamRepository.deleteByGame(Game.toName(id));
    await repository.deleteById(id);
  }
}
