import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noctur/routing/router.dart';

class Layout extends StatefulWidget {
  final Widget body;
  final int currentIndex;

  const Layout({required this.body, required this.currentIndex, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Echipe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad),
            label: 'Jocuri',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        currentIndex: widget.currentIndex,
        onTap: (index) {
          if (widget.currentIndex == index) {
            return;
          }
          GoRouter.of(context).push(tabs[index]!);
        },
      ),
    );
  }
}
