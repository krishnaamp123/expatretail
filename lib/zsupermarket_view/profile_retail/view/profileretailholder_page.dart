import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class ProfileRetailHolderPage extends StatefulWidget {
  const ProfileRetailHolderPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileRetailHolderPage> createState() =>
      _ProfileRetailHolderPageState();
}

class _ProfileRetailHolderPageState extends State<ProfileRetailHolderPage> {
  var profileretailCon = Get.put(ProfileRetailSuperController());
  bool isDataLoaded = false;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    _refreshData();
    _loadData();
  }

  // Fungsi untuk memuat data
  void _loadData() async {
    await profileretailCon.getProfileRetail();
    setState(() {
      isDataLoaded = true;
    });
  }

  // Function to handle refreshing
  Future<void> _refreshData() async {
    await profileretailCon.getProfileRetail();
    setState(() {});
  }

  // Function to filter the profiles
  List filterProfiles() {
    return profileretailCon.listProfileRetail.where((profile) {
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
                  profileretailCon.isLoading.value
                      ? const SpinKitWanderingCubes(
                          color: Color.fromRGBO(114, 162, 138, 1),
                          size: 50.0,
                        )
                      : Expanded(
                          child: Card(
                            color: const Color.fromRGBO(26, 26, 26, 1),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: filterProfiles().length,
                              padding: const EdgeInsets.only(bottom: 10),
                              itemExtent: 100,
                              itemBuilder: (BuildContext context, int index) {
                                var profileretail = filterProfiles()[index];
                                return menuCard(
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

  Widget menuCard(
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
            builder: (context) => StockPage(
              idCustomer: idCustomer,
              customerName: customerName,
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
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  Expanded(
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
