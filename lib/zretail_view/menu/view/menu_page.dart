import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class MenuRetailPage extends StatefulWidget {
  const MenuRetailPage({Key? key}) : super(key: key);

  @override
  State<MenuRetailPage> createState() => _MenuRetailPageState();
}

class _MenuRetailPageState extends State<MenuRetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarCart(context, "MENU"),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(114, 162, 138, 1),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          "RETAIL ITEM",
                          16,
                          Colors.white,
                          FontWeight.normal,
                          letterSpace: 0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            // Menggunakan Expanded di sini
            child: Card(
                color: const Color.fromRGBO(26, 26, 26, 1),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const ItemRetailHolderPage()),
          ),

          //Item Holder
        ]),
      ),
    );
  }
}
