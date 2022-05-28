import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrouter/vrouter.dart';

import 'auth/auth_providers.dart';
import 'auth/auth_state.dart';

class AuthGuard extends ConsumerStatefulWidget {
  final Widget child;

  const AuthGuard({Key? key, required this.child}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthGuardState();
}

class _AuthGuardState extends ConsumerState<AuthGuard> {
  late final RemoveListener removeListener;

  void _onAuthStateChange(AuthState state) {
    if (state.loading) {
      return VRouter.of(context).to('/');
    }
    if (state.user == null) {
      return VRouter.of(context).to('/');
    }
    return VRouter.of(context).to('/tabs/teams');
  }

  @override
  void initState() {
    super.initState();
    final authNotifier = ref.read(authStateProvider.notifier);
    removeListener =
        authNotifier.addListener(_onAuthStateChange, fireImmediately: false);
  }

  @override
  void dispose() {
    removeListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
