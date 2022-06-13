import 'package:flutter/material.dart';

class StyledList<T> extends StatelessWidget {
  final ScrollController? controller;
  final List<T> items;
  final Widget Function(BuildContext, int)? itemBuilder;
  final Widget Function(T)? displayBuilder;
  final double? gap;
  final bool paddedTop;
  final EdgeInsets? padding;
  final bool reverse;
  final Widget? whenEmpty;

  const StyledList({
    this.controller,
    required this.items,
    this.itemBuilder,
    this.displayBuilder,
    this.gap,
    this.paddedTop = false,
    this.padding,
    this.reverse = false,
    this.whenEmpty,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (whenEmpty != null) {
      if (items.isEmpty) {
        return Container(
          alignment: Alignment.center,
          child: whenEmpty,
        );
      }
    }

    if (!paddedTop) {
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: gap != null
            ? _SeparatedListView(
                controller: controller,
                displayBuilder: displayBuilder,
                itemBuilder: itemBuilder,
                items: items,
                gap: gap!,
                padding: padding,
                reverse: reverse,
              )
            : _SimpleListView(
                controller: controller,
                displayBuilder: displayBuilder,
                itemBuilder: itemBuilder,
                items: items,
                padding: padding,
                reverse: reverse,
              ),
      );
    }

    return gap != null
        ? _SeparatedListView(
            controller: controller,
            displayBuilder: displayBuilder,
            itemBuilder: itemBuilder,
            items: items,
            gap: gap!,
            padding: padding,
            reverse: reverse,
          )
        : _SimpleListView(
            controller: controller,
            displayBuilder: displayBuilder,
            itemBuilder: itemBuilder,
            items: items,
            padding: padding,
            reverse: reverse,
          );
  }
}

class _SimpleListView<T> extends StatelessWidget {
  final ScrollController? controller;
  final List<T> items;
  final Widget Function(BuildContext, int)? itemBuilder;
  final Widget Function(T)? displayBuilder;
  final EdgeInsets? padding;
  final bool reverse;

  const _SimpleListView({
    this.controller,
    required this.items,
    this.itemBuilder,
    this.displayBuilder,
    this.padding,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: key,
      controller: controller,
      padding: padding,
      reverse: reverse,
      itemCount: items.length,
      itemBuilder: (context, index) =>
          itemBuilder?.call(context, index) ??
          displayBuilder?.call(items[index]) ??
          const SizedBox.shrink(),
    );
  }
}

class _SeparatedListView<T> extends StatelessWidget {
  final ScrollController? controller;
  final List<T> items;
  final Widget Function(BuildContext, int)? itemBuilder;
  final Widget Function(T)? displayBuilder;
  final double gap;
  final EdgeInsets? padding;
  final bool reverse;

  const _SeparatedListView({
    this.controller,
    required this.items,
    this.itemBuilder,
    this.displayBuilder,
    this.gap = 0,
    this.padding,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: key,
      controller: controller,
      padding: padding,
      reverse: reverse,
      separatorBuilder: (context, index) => SizedBox(height: gap),
      itemCount: items.length,
      itemBuilder: (context, index) =>
          itemBuilder?.call(context, index) ??
          displayBuilder?.call(items[index]) ??
          const SizedBox.shrink(),
    );
  }
}
