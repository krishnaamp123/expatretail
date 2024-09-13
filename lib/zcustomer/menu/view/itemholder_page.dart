// import 'package:flutter/material.dart';
// import 'package:expatretail/core.dart';

// class ItemHolderPage extends StatefulWidget {
//   final TextEditingController alamatController;
//   final TextEditingController namapesananController;
//   final GlobalKey<FormState> formKey;

//   const ItemHolderPage({
//     super.key,
//     required this.alamatController,
//     required this.namapesananController,
//     required this.formKey,
//   });

//   @override
//   State<ItemHolderPage> createState() => _PackageListState();
// }

// class _PackageListState extends State<ItemHolderPage> {
//   var paketCon = Get.put(PaketController());
//   bool isDataLoaded = false;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _refreshData();
//     _loadData();
//   }

//   // Fungsi untuk memuat data
//   void _loadData() async {
//     await paketCon.getPaket();
//     setState(() {
//       isDataLoaded = true;
//     });
//   }

//   // Function to handle refreshing
//   Future<void> _refreshData() async {
//     await paketCon.getPaket();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: _refreshData,
//       child: isDataLoaded
//           ? SizedBox(
//               height: 320,
//               width: MediaQuery.of(context).size.width,
//               child: Obx(
//                 () => paketCon.isLoading.value
//                     ? const SpinKitWanderingCubes(
//                         color: Colors.deepPurple,
//                         size: 50.0,
//                       )
//                     : ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: paketCon.listPaket.length,
//                         padding: const EdgeInsets.only(bottom: 10),
//                         itemExtent: 100,
//                         itemBuilder: (BuildContext context, int index) {
//                           var paket = paketCon.listPaket[index];
//                           return paketCard(
//                               paket.id.toString(),
//                               paket.packageName.toString(),
//                               paket.mainImage.toString(),
//                               paket.description.toString(),
//                               paket.itemPrice.toString()
//                         },
//                       ),
//               ),
//             )
//           : const Center(
//               child: SpinKitWanderingCubes(
//               color: Colors.deepPurple,
//               size: 50.0,
//             ) // Tampilkan loading indicator jika data masih dimuat
//               ),
//     );
//   }

//   Widget paketCard(
//       String idpaket,
//       String name,
//       String image,
//       String description,
//       String itemprice,) {
//     int hargaInt = int.parse(itemprice);
//     String formatteditemprice =
//         NumberFormat.currency(locale: 'id', symbol: 'Rp.', decimalDigits: 0)
//             .format(hargaInt);
//     final imageURL = '$baseURL/resource/packages/$idpaket/main_image/';
//     print('Image URL: $imageURL');
//     return InkWell(
//       onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => PaketLayanan(
//                   idpaket: idpaket,
//                   image: image,
//                   name: name,
//                   description: description,
//                   itemprice: itemprice,
//                 ),
//               ),
//             );
//       },
//       child: Card(
//         color: Colors.white,
//         elevation: 2,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: SizedBox(
//           height: 100,
//           width: double.infinity,
//           child: Row(
//             children: [
//               const SizedBox(
//                 width: 15,
//               ),
//               CircleAvatar(
//                 radius: 30,
//                 backgroundImage: NetworkImage(
//                   imageURL,
//                 ),
//                 onBackgroundImageError: (error, stackTrace) {
//                   print('Error loading image: $error');
//                 },
//                 backgroundColor: const Color.fromRGBO(193, 71, 233, 1),
//               ),
//               const SizedBox(
//                 width: 15,
//               ),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       name,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         color: Color.fromRGBO(45, 3, 59, 1),
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 0,
//                       ),
//                       textAlign: TextAlign.left,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     TextWidget(
//                       formatteditemprice,
//                       15,
//                       const Color.fromRGBO(193, 71, 233, 1),
//                       FontWeight.normal,
//                       letterSpace: 0,
//                       textAlign: TextAlign.left,
//                     ),
//                     Text(
//                       description,
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.black.withOpacity(.6),
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.left,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class ItemHolderPage extends StatefulWidget {
  const ItemHolderPage({super.key});

  @override
  State<ItemHolderPage> createState() => _PackageListState();
}

class _PackageListState extends State<ItemHolderPage> {
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

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {}, // Tidak perlu refresh karena data dummy
      child: isDataLoaded
          ? SingleChildScrollView(
              child: Card(
                color: const Color.fromRGBO(26, 26, 26, 1),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SizedBox(
                  height: 700,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: dummyData.length,
                    padding: const EdgeInsets.only(bottom: 10),
                    itemExtent: 130,
                    itemBuilder: (BuildContext context, int index) {
                      var paket = dummyData[index];
                      return paketCard(
                        paket['idpaket']!,
                        paket['name']!,
                        paket['image']!,
                        paket['description']!,
                        paket['itemprice']!,
                      );
                    },
                  ),
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
  ) {
    int hargaInt = int.parse(itemprice);
    String formatteditemprice = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp.',
      decimalDigits: 0,
    ).format(hargaInt);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuDetailPage(
              idpaket: idpaket,
              image: image,
              name: name,
              description: description,
              itemprice: itemprice,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Card(
            color: const Color.fromRGBO(26, 26, 26, 1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              height: 120,
              width: double.infinity,
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      image,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
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
                          description,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatteditemprice,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(114, 162, 138, 1),
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.add_circle_outline,
                                size: 30,
                                color: Color.fromRGBO(114, 162, 138, 1),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MenuDetailPage(
                                      idpaket: idpaket,
                                      image: image,
                                      name: name,
                                      description: description,
                                      itemprice: itemprice,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
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
              thickness: 4,
              color: Color.fromRGBO(33, 33, 33, 1),
            ),
          ),
        ],
      ),
    );
  }
}
