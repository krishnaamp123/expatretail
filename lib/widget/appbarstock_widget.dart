import 'package:expatretail/core.dart';
import 'package:flutter/material.dart';

AppBar buildAppBarStock(BuildContext context, String title) {
  return AppBar(
    iconTheme: const IconThemeData(size: 28, color: Colors.white),
    leading: Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigationSuperPage(initialIndex: 0),
            ),
          );
        },
      ),
    ),
    title: Text(
      title, // Title is dynamic
      style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.normal,
          letterSpacing: 0,
          color: Colors.white),
    ),
    centerTitle: true,
    toolbarHeight: 80,
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
