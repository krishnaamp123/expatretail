import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class ItemHolderPage extends StatefulWidget {
  const ItemHolderPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ItemHolderPage> createState() => _ItemHolderPageState();
}

class _ItemHolderPageState extends State<ItemHolderPage> {
  var menuCon = Get.put(MenuItemController());
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Fungsi untuk memuat data
  void _loadData() async {
    await _refreshData();
    await menuCon.getMenu();
    setState(() {
      isDataLoaded = true;
    });
  }

  // Function to handle refreshing
  Future<void> _refreshData() async {
    await menuCon.getMenu();
    setState(() {});
  }

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
                  child: Obx(
                    () => menuCon.isLoading.value
                        ? const SpinKitWanderingCubes(
                            color: Color.fromRGBO(114, 162, 138, 1),
                            size: 50.0,
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: menuCon.listMenu.length,
                            padding: const EdgeInsets.only(bottom: 10),
                            itemExtent: 130,
                            itemBuilder: (BuildContext context, int index) {
                              var menu = menuCon.listMenu[index];
                              return paketCard(
                                menu.id!.toInt(),
                                menu.price!.toInt(),
                                menu.product!.productName.toString(),
                                menu.product!.image.toString(),
                                menu.product!.descriprtion.toString(),
                                menu.product!.packaging!.packagingName
                                    .toString(),
                                menu.product!.packaging!.weight!.toInt(),
                              );
                            },
                          ),
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
    int id,
    int price,
    String productname,
    String image,
    String description,
    String packagingname,
    int weight,
  ) {
    String formatteditemprice = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp.',
      decimalDigits: 0,
    ).format(price);

    final fullImageUrl = '$baseURL/storage/image/$image';

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuDetailPage(
              id: id,
              price: price,
              productname: productname,
              image: image,
              description: description,
              packagingname: packagingname,
              weight: weight,
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
                    child: Image.network(
                      fullImageUrl,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'lib/image/logokotak.png',
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        );
                      },
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const CircularProgressIndicator();
                      },
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
                          productname,
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
                                      id: id,
                                      price: price,
                                      productname: productname,
                                      image: image,
                                      description: description,
                                      packagingname: packagingname,
                                      weight: weight,
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
