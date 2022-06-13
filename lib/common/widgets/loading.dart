import 'package:flutter/material.dart';

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}

class Loading extends StatelessWidget {
  final bool condition;
  final Widget? child;
  final BoxFit? fit;

  const Loading({
    this.condition = true,
    this.child,
    this.fit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (condition || child == null) {
      if (fit != null) {
        return FittedBox(
          fit: fit!,
          child: const _LoadingIndicator(),
        );
      }
      return const _LoadingIndicator();
    }
    return child!;
  }
}
