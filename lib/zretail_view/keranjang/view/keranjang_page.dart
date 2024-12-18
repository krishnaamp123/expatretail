import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class KeranjangRetailPage extends StatefulWidget {
  const KeranjangRetailPage({
    super.key,
  });

  @override
  State<KeranjangRetailPage> createState() => _KeranjangRetailPageState();
}

class _KeranjangRetailPageState extends State<KeranjangRetailPage> {
  String userAddress = '';
  @override
  void initState() {
    super.initState();
    _loadAddressData();
  }

  _loadAddressData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var addressData = localStorage.getString('user');
    if (addressData != null) {
      var address = jsonDecode(addressData);
      if (address != null && address['address'] != null) {
        String fullAddress = address['address'];
        setState(() {
          userAddress = fullAddress;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "CART"),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Delivery Address",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0,
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.home_outlined,
                        size: 35,
                        color: Color.fromRGBO(114, 162, 138, 1),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Expat. Roastery",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(114, 162, 138, 1),
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "Jl. Gunung Salak No.35XXX, Denpasar, Bali",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "I",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(114, 162, 138, 1),
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.location_on_outlined,
                        size: 35,
                        color: Color.fromRGBO(114, 162, 138, 1),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Recipient",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(114, 162, 138, 1),
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          userAddress,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: 20,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          "Please make sure the delivery address is correct",
                          12,
                          Colors.black,
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
          const SizedBox(height: 10),
          const Divider(
            height: 2,
            thickness: 4,
            color: Color.fromRGBO(33, 33, 33, 1),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Detail Order",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ]),
          ),
          const SizedBox(height: 5),
          const Expanded(
            // Menggunakan Expanded di sini
            child: KeranjangRetailHolderPage(),
          ),
        ]),
      ),
    );
  }
}
