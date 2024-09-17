import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class ComplaintPage extends StatefulWidget {
  final Function()? onTap;
  const ComplaintPage({super.key, this.onTap});

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  final _formKey = GlobalKey<FormState>();
  final ComplaintController complaintController = ComplaintController();
  File? _profileImage;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final directory = await getApplicationDocumentsDirectory();
      final name = path.basename(image.path);
      final imageFile = File('${directory.path}/$name');
      final newImage = await File(image.path).copy(imageFile.path);

      setState(() {
        _profileImage = newImage;
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarTok(context, "COMPLAINT"),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.black,
          // padding: const EdgeInsets.only(top: 60),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //add photo
                Center(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: _profileImage != null
                            ? Image.file(
                                _profileImage!,
                                fit: BoxFit.cover,
                                width: 200,
                                height: 200,
                              )
                            : Image.asset(
                                'lib/image/uploadphoto.png',
                                fit: BoxFit.cover,
                                width: 200,
                                height: 200,
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: buildEditIcon(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                //tanggal dan kode barang
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const TextWidget(
                        "Complaint Date",
                        13,
                        Colors.white,
                        FontWeight.normal,
                        letterSpace: 0,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final DateTime? dateTime = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2025),
                          );
                          if (dateTime != null) {
                            setState(() {
                              selectedDate = dateTime;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 32, right: 32, top: 12, bottom: 12),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(114, 162, 138, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "${selectedDate.year} - ${selectedDate.month} - ${selectedDate.day}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                //production code textfield
                TextFieldWidget(
                  controller: complaintController.kodeproduksiController,
                  upText: 'Production Code',
                  hintText: 'Enter your production code',
                  obscureText: false,
                  validator: complaintController
                      .validateKodeProduksi, // Set validator dari controller
                  onChanged: (_) {
                    setState(() {
                      complaintController.kodeproduksiError = null;
                    });
                  },
                ),
                const SizedBox(height: 10),

                //complaint textfield
                TextFieldComplaint(
                  controller: complaintController.descriptionController,
                  upText: 'Complaint Description',
                  hintText: 'Enter your complaint',
                  obscureText: false,
                  validator: complaintController
                      .validateDescription, // Set validator dari controller
                  onChanged: (_) {
                    setState(() {
                      complaintController.descriptionError = null;
                    });
                  },
                ),

                const SizedBox(height: 30),

                //sign in button
                ButtonWidget(
                  text: "SEND",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _showConfirmationDialog();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon() => buildCircle(
        all: 3,
        color: Colors.white,
        child: buildCircle(
          color: const Color.fromRGBO(114, 162, 138, 1),
          all: 8,
          child: const Icon(
            Icons.photo_camera,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            "Confirm Complaint",
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
                "Are you sure you want to make this complaint?",
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
                  onPressed: () {},
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
