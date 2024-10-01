import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class KeranjangHolderPage extends StatefulWidget {
  const KeranjangHolderPage({super.key});

  @override
  State<KeranjangHolderPage> createState() => _PackageListState();
}

class _PackageListState extends State<KeranjangHolderPage> {
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

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
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
                              _showRemoveConfirmationDialog;
                            } else {
                              setState(() {
                                qty = value;
                              });
                            }
                          },
                          // messageBuilder: (minVal, maxVal, value) {
                          //   if (value == null || value == 0) {
                          //     return const Text(
                          //       "Minimal 1",
                          //       style: TextStyle(color: Colors.red),
                          //       textAlign: TextAlign.center,
                          //     );
                          //   } else if (value > 30) {
                          //     return const Text(
                          //       "Maksimal 30",
                          //       style: TextStyle(color: Colors.red),
                          //       textAlign: TextAlign.center,
                          //     );
                          //   } else {
                          //     return const SizedBox();
                          //     Text(
                          //       "Jumlah : $value",
                          //       style: const TextStyle(
                          //         color: Colors.white,
                          //       ),
                          //       textAlign: TextAlign.center,
                          //     );
                          //   }
                          // },
                        ),
                        // const SizedBox(width: 0),
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

  void _showRemoveConfirmationDialog(int qty) {
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
                  //
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
