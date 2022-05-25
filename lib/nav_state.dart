import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabs = {
  '/tabs/teams': 0,
  '/tabs/games': 1,
  '/tabs/games/add': 1,
  '/tabs/user': 2,
};

class NavState {
  final int index;
  final String tab;

  const NavState({
    required this.index,
    required this.tab,
  });

  NavState _setIndex(int index) {
    final tab = tabs.keys.firstWhere((element) => tabs[element] == index);
    return NavState(index: index, tab: tab);
  }

  NavState _setTab(String tab) {
    final index = tabs[tab]!;
    return NavState(index: index, tab: tab);
  }

  bool hasSameIndex(int index) => index == this.index;
}

class NavStateNotifier extends StateNotifier<NavState> {
  NavStateNotifier() : super(const NavState(index: 0, tab: '/tabs/teams'));

  void setIndex(int index) {
    state = state._setIndex(index);
  }

  void setTab(String tab) {
    state = state._setTab(tab);
  }
}

final navStateNotifierProvider =
    StateNotifierProvider.autoDispose<NavStateNotifier, NavState>((ref) {
  return NavStateNotifier();
});
