import 'package:flutter/material.dart';

AppBar buildAppBarTok(BuildContext context, String title) {
  return AppBar(
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
    backgroundColor: Colors.black,
    elevation: 0,
    automaticallyImplyLeading: false,
  );
}
