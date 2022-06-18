import 'dart:io';

import 'package:palwin/common/database.dart';
import 'package:palwin/common/exceptions.dart';
import 'package:palwin/common/storage.dart';
import 'package:palwin/game/logic/game.dart';
import 'package:palwin/team/logic/teams_service.dart';
import 'package:path/path.dart';

class GamesService {
  final BaseRepository<Game> _repository;
  final TeamsService _teamsService;
  final StorageService _storage;

  const GamesService(this._repository, this._teamsService, this._storage);

  Stream<List<Game>> getAllWithIcons$() {
    return _repository
        .getAll$()
        .asyncMap((event) => Future.wait(event.map((e) async {
              if (e.iconPath.isNotEmpty) {
                final iconURL = await _storage.getDownloadURL(e.iconPath);
                return e.copyWith(downloadURL: iconURL);
              }
              return e;
            })));
  }

  Stream<List<Game>> getIcons(Stream<List<Game>> games$) {
    return games$.asyncMap((event) => Future.wait(event.map((e) async {
          if (e.iconPath.isNotEmpty) {
            final icon = await _storage.getFile(e.iconPath);
            return e.copyWith(icon: icon);
          }
          return e;
        })));
  }

  Future<void> addFromForm({
    required String name,
    required String teamSize,
    required File? file,
  }) async {
    final parsedTeamSize = int.parse(teamSize);

    if (parsedTeamSize < 2) {
      throw const TeamSizeTooSmall();
    }

    var iconPath = '';

    if (file != null) {
      final ext = basename(file.path).split('.').last;
      iconPath = 'games/${Game.toId(name)}.$ext';
      await _storage.saveFile(file, iconPath);
    }

    final game = Game(name: name, teamSize: parsedTeamSize, iconPath: iconPath);
    try {
      await _repository.add(game);
    } on ResourceAlreadyExists {
      throw GameAlreadyExists(game);
    }
  }

  Future<void> deleteGame(Game game) async {
    await _teamsService
        .deleteWhere(QueryFilter().equalsTo(key: 'gameId', value: game.id));
    await _repository.deleteById(game.id);
  }
}
