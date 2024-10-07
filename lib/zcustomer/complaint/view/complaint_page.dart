import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
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
  int? userid;

  @override
  void initState() {
    super.initState();
    _loadIdData();
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

  Future<void> _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      // Memastikan ukuran file tidak terlalu besar
      final bytes = await image.readAsBytes();
      const maxSizeInBytes = 2 * 1024 * 1024; // Contoh batas ukuran 2MB
      if (bytes.lengthInBytes > maxSizeInBytes) {
        print('File terlalu besar. Ukuran file maksimal adalah 2MB.');
        return;
      }

      // Jika ukuran file sesuai, lanjutkan proses
      final directory = await getApplicationDocumentsDirectory();
      final name = path.basename(image.path);
      final imageFile = File('${directory.path}/$name');
      final newImage = await File(image.path).copy(imageFile.path);

      setState(() {
        _profileImage = newImage; // Simpan gambar yang dipilih
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
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

                // Tanggal dan kode barang
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
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () async {
                          final DateTime? dateTime = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2025),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData(
                                  colorScheme: const ColorScheme.light(
                                    primary: Color.fromRGBO(114, 162, 138, 1),
                                    onPrimary: Colors.white,
                                    onSurface: Colors.black,
                                  ),
                                  dialogBackgroundColor: Colors.white,
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (dateTime != null) {
                            setState(() {
                              selectedDate = dateTime;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
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

                // Production code textfield
                TextFieldWidget(
                  controller: complaintController.kodeproduksiController,
                  upText: 'Production Code',
                  hintText: 'Enter your production code',
                  obscureText: false,
                  validator: complaintController.validateKodeProduksi,
                  onChanged: (_) {
                    setState(() {
                      complaintController.kodeproduksiError = null;
                    });
                  },
                ),
                const SizedBox(height: 10),

                // Complaint textfield
                TextFieldComplaint(
                  controller: complaintController.descriptionController,
                  upText: 'Complaint Description',
                  hintText: 'Enter your complaint',
                  obscureText: false,
                  validator: complaintController.validateDescription,
                  onChanged: (_) {
                    setState(() {
                      complaintController.descriptionError = null;
                    });
                  },
                ),

                const SizedBox(height: 30),

                // Send button
                ButtonWidget(
                  text: "SEND",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (_profileImage == null) {
                        print("Error: No image selected.");
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Please select an image before submitting.")));
                        return;
                      }
                      _showConfirmationDialog();
                    }
                  },
                ),
                const SizedBox(height: 20),
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
                      borderRadius: BorderRadius.circular(10),
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
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    complaintController.sendComplaint(
                        userid!, _profileImage!, selectedDate);
                    const snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Success!',
                        color: Color.fromRGBO(114, 162, 138, 1),
                        message: 'Thank you, complaint successfully sent!',
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
                      borderRadius: BorderRadius.circular(10),
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
                    ),
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
