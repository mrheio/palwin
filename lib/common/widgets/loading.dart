import 'package:flutter/material.dart';
import 'package:noctur/common/styles.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bg,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
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
