import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class KeranjangHolderPage extends StatefulWidget {
  const KeranjangHolderPage({super.key});

  @override
  State<KeranjangHolderPage> createState() => _PackageListState();
}

class _PackageListState extends State<KeranjangHolderPage> {
  bool isDataLoaded = true; // Set true karena data dummy langsung tersedia

  // Data dummy untuk digunakan
  final List<Map<String, String>> dummyData = [
    {
      'idpaket': '1',
      'name': 'Nomad',
      'image': 'lib/image/produk1.png',
      'description': 'Description1',
      'itemprice': '150000'
    },
    {
      'idpaket': '2',
      'name': 'Patria',
      'image': 'lib/image/produk2.png',
      'description': 'Description2',
      'itemprice': '250000'
    },
    {
      'idpaket': '3',
      'name': 'Habitat',
      'image': 'lib/image/produk3.png',
      'description': 'Description3',
      'itemprice': '450000'
    }
  ];

  // Menyimpan nilai kuantitas untuk setiap item
  List<int> itemQuantities = [1, 1, 1];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {}, // Tidak perlu refresh karena data dummy
      child: isDataLoaded
          ? SingleChildScrollView(
              child: SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: dummyData.length,
                  padding: const EdgeInsets.only(bottom: 10),
                  itemExtent: 90,
                  itemBuilder: (BuildContext context, int index) {
                    var paket = dummyData[index];
                    return paketCard(
                      paket['idpaket']!,
                      paket['name']!,
                      paket['image']!,
                      paket['description']!,
                      paket['itemprice']!,
                      index,
                    );
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

  Widget paketCard(
    String idpaket,
    String name,
    String image,
    String description,
    String itemprice,
    int index,
  ) {
    int hargaInt = int.parse(itemprice);
    String formatteditemprice = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp.',
      decimalDigits: 0,
    ).format(hargaInt);

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
                  child: Image.asset(
                    image,
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
                              name,
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
                          initVal: itemQuantities[index],
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
                              _showRemoveConfirmationDialog(index);
                            } else {
                              setState(() {
                                itemQuantities[index] = value;
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

  void _showRemoveConfirmationDialog(int index) {
    int previousQuantity = itemQuantities[index];
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
                  itemQuantities[index] = previousQuantity;
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
                  dummyData.removeAt(index);
                  itemQuantities.removeAt(index);
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
