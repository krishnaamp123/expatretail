import 'dart:convert';

import 'package:expatretail/core.dart';
import 'package:flutter/material.dart';

class ProfileRetailPage extends StatefulWidget {
  const ProfileRetailPage({super.key});

  @override
  State<ProfileRetailPage> createState() => _ProfileRetailPageState();
}

class _ProfileRetailPageState extends State<ProfileRetailPage> {
  var profileCon = Get.put(ProfileRetailController());
  bool isDataLoaded = false;
  int? userid;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await _loadIdData();
    await _loadData();
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

  Future<void> _loadData() async {
    if (userid != null) {
      await _refreshData();
      profileCon.setUserId(userid!);
      setState(() {
        isDataLoaded = true;
      });
    }
  }

  Future<void> _refreshData() async {
    if (userid != null) {
      profileCon.setUserId(userid!);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarTok(context, "PROFILE"),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: isDataLoaded
            ? Obx(
                () => profileCon.isLoading.value
                    ? const Center(
                        child: SpinKitWanderingCubes(
                          color: Color.fromRGBO(114, 162, 138, 1),
                          size: 50.0,
                        ),
                      )
                    : SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: profileCon.listProfile.map((profileuser) {
                            var user = profileuser;
                            var userprofile = profileuser.company;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  color: const Color.fromRGBO(26, 26, 26, 1),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: SizedBox(
                                    // height: 120,
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Image.asset(
                                            'lib/image/expatlogo.png',
                                            height: 100,
                                            width: 200,
                                          ),
                                        ),
                                        Text(
                                          userprofile!.companyName!,
                                          style: const TextStyle(
                                            color: Color.fromRGBO(
                                                114, 162, 138, 1),
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          user.picName!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Username :',
                                  style: TextStyle(
                                    color: Color.fromRGBO(114, 162, 138, 1),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  user.username!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Alamat :',
                                  style: TextStyle(
                                    color: Color.fromRGBO(114, 162, 138, 1),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  user.address!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Nomor Telepon :',
                                  style: TextStyle(
                                    color: Color.fromRGBO(114, 162, 138, 1),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  user.picPhone!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ChangePassRetailPage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          114, 162, 138, 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'CHANGE PASSWORD',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
              )
            : const Center(
                child: SpinKitWanderingCubes(
                  color: Color.fromRGBO(114, 162, 138, 1),
                  size: 50.0,
                ),
              ),
      ),
    );
  }
}
