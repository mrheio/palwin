import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class Loading extends StatelessWidget {
  final bool condition;
  final Widget? child;

  const Loading({required this.condition, this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (child == null) {
      return const Scaffold(body: LoadingIndicator());
    }
    if (condition) {
      return const LoadingIndicator();
    }
    return child!;
  }
}
