import 'package:flutter/material.dart';

AppBar buildAppBarTok(BuildContext context, String title) {
  return AppBar(
    // iconTheme: const IconThemeData(size: 28, color: Colors.white),
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
    backgroundColor: Colors.black,
    elevation: 0,
  );
}
