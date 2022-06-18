import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/utils/async_state.dart';
import 'package:noctur/user/logic/logic.dart';

import '../../common/exceptions.dart';
import '../../common/success.dart';

class AccountNotifier extends StateNotifier<AsyncStatus> {
  final ComplexUser user;
  final UsersService _usersService;

  AccountNotifier(this.user, this._usersService) : super(const NormalStatus());

  Future<void> updateUsername(String username) async {
    state = const LoadingStatus();
    try {
      await _usersService.update(user.copyWith(username: username));
      state = const SuccessStatus(Success('Date actualizate'));
    } on AuthException catch (error) {
      state = FailStatus(error);
    }
  }

  Future<void> addFriend(Friend friend) async {
    state = const LoadingStatus();
    try {
      await _usersService.addFriend(user, friend);
      state = const NormalStatus();
    } on CustomException catch (error) {
      state = FailStatus(error);
    }
  }

  Future<void> deleteFriend(SimpleUser friend) async {
    state = const LoadingStatus();
    try {
      await _usersService.deleteFriend(user, friend);
      state = const NormalStatus();
    } on CustomException catch (error) {
      state = FailStatus(error);
    }
  }
}
