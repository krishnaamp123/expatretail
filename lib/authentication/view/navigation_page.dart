import 'package:expatretail/core.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  // final String service_user;
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final items = const [
    Icon(
      Icons.home_filled,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.payment,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.history_rounded,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.person,
      color: Colors.white,
      size: 30,
    ),
  ];

  int index = 1;

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
        color: const Color.fromRGBO(45, 3, 59, 1),
        backgroundColor: Colors.white,
        buttonBackgroundColor: const Color.fromRGBO(45, 3, 59, 1),
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
        widget = const DashboardPage();
        break;
      case 1:
        widget = const MenuPage();
        break;
      case 2:
        widget = const ProfilePage();
        break;
      default:
        widget = const DashboardPage();
        break;
    }
    return widget;
  }
}
