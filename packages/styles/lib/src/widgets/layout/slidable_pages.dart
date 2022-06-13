import 'package:flutter/material.dart';
import 'package:styles/src/widgets/layout/styled_column.dart';

class SlidablePages extends StatefulWidget {
  final List<Widget> tabs;
  final List<Widget> children;
  final PageController controller;

  const SlidablePages({
    this.tabs = const [],
    this.children = const [],
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SlidablePagesState();
  }
}

class _SlidablePagesState extends State<SlidablePages>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: widget.children.length, vsync: this);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void handlePageChanged(int index) {
    _tabController.animateTo(index);
  }

  void handleTabBarTap(int index) {
    widget.controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StyledColumn(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 42,
          child: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            labelPadding: const EdgeInsets.symmetric(horizontal: 12),
            isScrollable: true,
            tabs: widget.tabs,
            onTap: handleTabBarTap,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.primary.withAlpha(75),
            ),
          ),
        ),
        Expanded(
          child: PageView(
            controller: widget.controller,
            onPageChanged: handlePageChanged,
            children: widget.children,
          ),
        )
      ],
    );
  }
}
