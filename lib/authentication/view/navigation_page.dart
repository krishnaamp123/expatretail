import 'package:expatretail/core.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  // final String service_user;
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final items = const [
    Icon(
      Icons.shopping_cart,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.report,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.person,
      color: Colors.white,
      size: 30,
    ),
  ];

  int index = 0;

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
        widget = const MenuPage();
        break;
      case 1:
        widget = const ComplaintPage();
        break;
      case 2:
        widget = const ProfilePage();
        break;
      default:
        widget = const MenuPage();
        break;
    }
    return widget;
  }
}
