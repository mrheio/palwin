import 'package:flutter/material.dart';

import 'floating_content.dart';
import 'navbar.dart';

class Layout extends StatefulWidget {
  final Widget body;

  const Layout({required this.body, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
      bottomNavigationBar: const Navbar(),
      floatingActionButton: const FloatingContent(),
    );
  }
}
