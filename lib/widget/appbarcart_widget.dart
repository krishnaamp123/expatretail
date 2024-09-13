import 'package:flutter/material.dart';

AppBar buildAppBarCart(BuildContext context, String title) {
  return AppBar(
    // iconTheme:
    //     const IconThemeData(size: 30, color: Color.fromRGBO(162, 162, 181, 1)),
    // leading: Padding(
    //   padding: const EdgeInsets.only(left: 16.0),
    //   child: IconButton(
    //     icon: const Icon(Icons.arrow_back_ios_rounded),
    //     onPressed: () {
    //       Navigator.of(context).pop();
    //     },
    //   ),
    // ),
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
    // Add cart icon to the right
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: IconButton(
          icon: const Icon(
            Icons.shopping_cart_outlined, // Cart icon
            size: 28,
            color: Colors.white,
          ),
          onPressed: () {
            // Handle cart icon press
          },
        ),
      ),
    ],
  );
}
