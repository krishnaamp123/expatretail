import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class KeranjangHolderPage extends StatefulWidget {
  const KeranjangHolderPage({super.key});

  @override
  State<KeranjangHolderPage> createState() => _KeranjangHolderPageState();
}

class _KeranjangHolderPageState extends State<KeranjangHolderPage> {
  var cartCon = Get.put(CartController());
  final OrderController orderController = OrderController();
  bool isDataLoaded = false;
  int? userid;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Fungsi untuk memuat data
  void _loadData() async {
    await _refreshData();
    await cartCon.getCart();
    setState(() {
      isDataLoaded = true;
    });
  }

  // Function to handle refreshing
  Future<void> _refreshData() async {
    await cartCon.getCart();
    _loadIdData();
    setState(() {});
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

  // Fungsi untuk menghitung total harga
  int _calculateTotalPrice() {
    int totalPrice = 0;
    for (var cart in cartCon.listCart) {
      totalPrice += cart.customerProduct!.price!.toInt() * cart.qty!.toInt();
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    String formattedTotalPrice = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp.',
      decimalDigits: 0,
    ).format(_calculateTotalPrice());

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: isDataLoaded
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cartCon.listCart.length,
                      padding: const EdgeInsets.only(bottom: 10),
                      itemExtent: 90,
                      itemBuilder: (BuildContext context, int index) {
                        var cart = cartCon.listCart[index];
                        return cartCard(
                            cart.id!.toInt(),
                            cart.idCustomer!.toInt(),
                            cart.idCustomerProduct!.toInt(),
                            cart.qty!.toInt(),
                            cart.customerProduct!.price!.toInt(),
                            cart.customerProduct!.product!.image.toString(),
                            cart.customerProduct!.product!.productName
                                .toString());
                      },
                    ),
                  ),
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
                            "Payment Summary",
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
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Payment",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(114, 162, 138, 1),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          formattedTotalPrice,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ButtonWidget(
                    text: "ORDER",
                    onTap: () {
                      _showConfirmationDialog();
                    },
                  ),
                ],
              ),
            )
          : const Center(
              child: SpinKitWanderingCubes(
              color: Color.fromRGBO(114, 162, 138, 1),
              size: 50.0,
            )),
    );
  }

  Widget cartCard(
    int id,
    int idcustomer,
    int idcustomerproduct,
    int qty,
    int price,
    String image,
    String productname,
  ) {
    String formatteditemprice = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp.',
      decimalDigits: 0,
    ).format(price);

    final fullImageUrl = '$baseURL/storage/image/$image';

    return Column(
      children: [
        Card(
          color: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            height: 80,
            width: double.infinity,
            child: Row(
              children: [
                const SizedBox(width: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    fullImageUrl,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'lib/image/logokotak.png',
                        fit: BoxFit.cover,
                        height: 70,
                        width: 70,
                      );
                    },
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const CircularProgressIndicator();
                    },
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productname,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0,
                              ),
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              formatteditemprice,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(114, 162, 138, 1),
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        InputQty.int(
                          initVal: qty,
                          qtyFormProps: const QtyFormProps(
                            enableTyping: false,
                            style: TextStyle(
                              color: Color.fromRGBO(114, 162, 138, 1),
                            ),
                          ),
                          decoration: const QtyDecorationProps(
                            isBordered: false,
                            borderShape: BorderShapeBtn.circle,
                            width: 10,
                            btnColor: Color.fromRGBO(114, 162, 138, 1),
                          ),
                          minVal: 0,
                          maxVal: 50,
                          steps: 1,
                          onQtyChanged: (value) {
                            if (value == 0 || value == null) {
                              _showRemoveConfirmationDialog(qty, id);
                            } else {
                              setState(() {
                                cartCon.listCart
                                    .firstWhere((cart) => cart.id == id)
                                    .qty = value;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(
            height: 2,
            thickness: 2,
            color: Color.fromRGBO(33, 33, 33, 1),
          ),
        ),
      ],
    );
  }

  void _showRemoveConfirmationDialog(int qty, int id) {
    int previousQuantity = qty;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            "Remove Item",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Would you like to remove this item from your cart?",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
          ),
          actions: [
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                setState(() {
                  qty = previousQuantity;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                "Remove",
                style: TextStyle(
                  color: Color.fromRGBO(114, 162, 138, 1),
                ),
              ),
              onPressed: () {
                setState(() {
                  cartCon.deleteCart(id);
                  _refreshData();
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            "Confirm Order",
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
                "Kantor Agency",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "Jl.Lorem Ipsum",
                style: TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.normal),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
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
                    orderController.createOrder(
                        userid!, _calculateTotalPrice());
                    const snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Success!',
                        color: Color.fromRGBO(114, 162, 138, 1),
                        message: 'Thank you, item successfully added!',
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
