import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class OrderHolderPage extends StatefulWidget {
  const OrderHolderPage({super.key});

  @override
  State<OrderHolderPage> createState() => _OrderHolderState();
}

class _OrderHolderState extends State<OrderHolderPage> {
  var cartCon = Get.put(CartController());
  bool isDataLoaded = false;

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
    setState(() {});
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
              child: SizedBox(
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
                        cart.customerProduct!.product!.productName.toString());
                  },
                ),
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
          color: const Color.fromRGBO(26, 26, 26, 1),
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
                setState(() async {
                  await cartCon.deleteCart(id);
                  await _refreshData();
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }
}
