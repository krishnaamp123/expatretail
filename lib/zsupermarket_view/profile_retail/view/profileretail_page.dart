import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class ProfileRetailSuperPage extends StatefulWidget {
  const ProfileRetailSuperPage({Key? key}) : super(key: key);

  @override
  State<ProfileRetailSuperPage> createState() => ProfileRetailSuperPageState();
}

class ProfileRetailSuperPageState extends State<ProfileRetailSuperPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarLogout(context, "SUPERMARKET"),
      backgroundColor: Colors.black,
      body: const SafeArea(
        child: Expanded(child: ProfileRetailHolderPage()),
      ),
    );
  }
}
