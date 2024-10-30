import 'package:expatretail/core.dart';
import 'package:flutter/material.dart';

class NavigationSuperPage extends StatefulWidget {
  final int initialIndex;
  const NavigationSuperPage({super.key, this.initialIndex = 0});

  @override
  State<NavigationSuperPage> createState() => _NavigationPageSSupertate();
}

class _NavigationPageSSupertate extends State<NavigationSuperPage> {
  late int index;

  final items = const [
    Icon(
      Icons.storefront_rounded,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.history_outlined,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.person,
      color: Colors.white,
      size: 30,
    ),
  ];

  @override
  void initState() {
    super.initState();
    index = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        index: index,
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
        },
        color: const Color.fromRGBO(26, 26, 26, 1),
        backgroundColor: Colors.black,
        buttonBackgroundColor: const Color.fromRGBO(26, 26, 26, 1),
        height: 60,
      ),
      body: Container(
        child: getSelectedWidget(index: index),
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const ProfileRetailSuperPage();
        break;
      case 1:
        widget = const ProfileRetailSuperPage();
        break;
      case 2:
        widget = const ProfileRetailSuperPage();
        break;
      default:
        widget = const ProfileRetailSuperPage();
        break;
    }
    return widget;
  }
}
