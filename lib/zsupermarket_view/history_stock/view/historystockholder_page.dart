import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class HistoryStockHolderPage extends StatefulWidget {
  const HistoryStockHolderPage({super.key});

  @override
  State<HistoryStockHolderPage> createState() => _HistoryStockHolderState();
}

class _HistoryStockHolderState extends State<HistoryStockHolderPage> {
  var profileretCon = Get.put(ProfileRetailSuperController());
  bool isDataLoaded = false;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    _refreshData();
    _loadData();
  }

  void _loadData() async {
    await profileretCon.getProfileRetail();
    setState(() {
      isDataLoaded = true;
    });
  }

  Future<void> _refreshData() async {
    await profileretCon.getProfileRetail();
    setState(() {});
  }

  // Function to filter the profiles
  List filterProfiles() {
    return profileretCon.listProfileRetail.where((profile) {
      final companyName = profile.company!.companyName.toString().toLowerCase();
      final customerName = profile.customerName.toString().toLowerCase();
      final picName = profile.picName.toString().toLowerCase();
      final query = searchText.toLowerCase();
      return companyName.contains(query) ||
          customerName.contains(query) ||
          picName.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      color: const Color.fromRGBO(114, 162, 138, 1),
      child: isDataLoaded
          ? Obx(
              () => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                      style: const TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 16, // Text size
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(114, 162, 138, 1),
                        hintText: "Search",
                        hintStyle: const TextStyle(
                          color: Colors.white, // Hint text color
                          fontSize: 16, // Hint text size
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white, // Icon color
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none, // Removes the border
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(114, 162, 138, 1),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(
                                26, 26, 26, 1), // Border color when focused
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  profileretCon.isLoading.value
                      ? const SpinKitWanderingCubes(
                          color: Color.fromRGBO(114, 162, 138, 1),
                          size: 50.0,
                        )
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: filterProfiles().length,
                            padding: const EdgeInsets.only(
                                bottom: 10, left: 15, right: 15),
                            itemExtent: 100,
                            itemBuilder: (BuildContext context, int index) {
                              var profileretail = filterProfiles()[index];
                              return profileretCard(
                                profileretail.id!.toInt(),
                                profileretail.company!.companyName.toString(),
                                profileretail.customerName.toString(),
                                profileretail.picName.toString(),
                                profileretail.picPhone.toString(),
                                profileretail.address.toString(),
                              );
                            },
                          ),
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

  Widget profileretCard(
    int idCustomer,
    String companyName,
    String customerName,
    String picName,
    String picPhone,
    String address,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HistoryStockDetailPage(
              idCustomer: idCustomer,
              companyName: companyName,
              customerName: customerName,
              picName: picName,
              picPhone: picPhone,
              address: address,
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
              height: 90,
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      companyName,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(114, 162, 138, 1),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      customerName,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      picName,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
