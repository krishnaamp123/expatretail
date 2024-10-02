import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class MenuDetailPage extends StatefulWidget {
  final int id;
  final int price;
  final String productname;
  final String image;
  final String description;
  final String packagingname;
  final int weight;

  const MenuDetailPage(
      {Key? key,
      required this.id,
      required this.price,
      required this.productname,
      required this.image,
      required this.description,
      required this.packagingname,
      required this.weight})
      : super(key: key);

  @override
  State<MenuDetailPage> createState() => _MenuDetailPageState();
}

class _MenuDetailPageState extends State<MenuDetailPage> {
  final CartController cartController = CartController();
  int? userid;
  int jumlahitem = 1;

  @override
  void initState() {
    super.initState();
    _loadIdData();
  }

  _loadIdData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var idData = localStorage.getString('user');
    if (idData != null) {
      var id = jsonDecode(idData);
      if (id != null && id['id'] is int) {
        setState(() {
          userid = id['id'];
        });
        print("idData from SharedPreferences: $userid");
      } else {
        print("ID bukan integer");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int itemprice = widget.price;
    String formattedItemPrice =
        NumberFormat.currency(locale: 'id', symbol: 'Rp.', decimalDigits: 0)
            .format(itemprice);
    String image = widget.image;
    final imageURL = '$baseURL/storage/image/$image';
    return Scaffold(
      appBar: buildAppBar(context, "MENU DETAIL"),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageURL,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'lib/image/logokotak.png',
                      fit: BoxFit.cover,
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.productname,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      formattedItemPrice,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(114, 162, 138, 1),
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  height: 2,
                  thickness: 4,
                  color: Color.fromRGBO(33, 33, 33, 1),
                ),
              ),
              const SizedBox(height: 15),
            ]),
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.black,
        height: 45,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InputQty.int(
                qtyFormProps: const QtyFormProps(
                  enableTyping: false,
                  style: TextStyle(
                    color: Color.fromRGBO(114, 162, 138, 1),
                  ),
                ),
                decoration: const QtyDecorationProps(
                  isBordered: false,
                  borderShape: BorderShapeBtn.circle,
                  width: 12,
                  btnColor: Color.fromRGBO(114, 162, 138, 1),
                ),
                initVal: jumlahitem,
                minVal: 1,
                maxVal: 50,
                steps: 1,
                onQtyChanged: (value) {
                  setState(() {
                    jumlahitem = value ?? 1;
                  });
                },
              ),
              GestureDetector(
                onTap: () {
                  _showConfirmationDialog();
                },
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(114, 162, 138, 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'ADD TO CART',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            "Confirm Cart",
            style: TextStyle(
              color: Color.fromRGBO(114, 162, 138, 1),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Are you sure you want to add this item to your cart?",
                style: TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.normal),
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Radius tombol
                    ),
                    backgroundColor: const Color.fromRGBO(33, 33, 33, 1),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0,
                    ), // Ukuran teks diperkecil
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    cartController.sendCart(userid!, widget.id, jumlahitem);
                    const snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Success!',
                        color: Color.fromRGBO(114, 162, 138, 1),
                        message: 'Thank you, complaint successfully sent!',
                        contentType: ContentType.success,
                      ),
                    );

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Radius tombol
                    ),
                    backgroundColor: const Color.fromRGBO(114, 162, 138, 1),
                  ),
                  child: const Text(
                    "Confirm",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0,
                    ), // Ukuran teks diperkecil
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
