import 'package:expatretail/core.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  final int initialIndex;
  const NavigationPage({super.key, this.initialIndex = 0});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  late int index;

  final items = const [
    Icon(
      Icons.shopping_cart,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.shopping_cart_checkout,
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

  @override
  void initState() {
    super.initState();
    index = widget.initialIndex; // Gunakan initialIndex dari widget
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
        widget = const MenuPage();
        break;
      case 1:
        widget = const OrderPage();
        break;
      case 2:
        widget = const ComplaintBarPage();
        break;
      case 3:
        widget = const ProfilePage();
        break;
      default:
        widget = const MenuPage();
        break;
    }
    return widget;
  }
}
