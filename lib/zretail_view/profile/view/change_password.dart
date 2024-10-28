import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class ChangePassRetailPage extends StatefulWidget {
  final Function()? onTap;
  const ChangePassRetailPage({super.key, this.onTap});

  @override
  State<ChangePassRetailPage> createState() => ChangePassRetailPageState();
}

class ChangePassRetailPageState extends State<ChangePassRetailPage> {
  final _formKey = GlobalKey<FormState>();
  final ProfileRetailController profileController = ProfileRetailController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarProfile(context, "CHANGE PASSWORD"),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              PassTextFieldWidget(
                controller: profileController.currentPasswordController,
                upText: 'Current Password',
                hintText: 'Enter your current password',
                validator: profileController.validatecurrentPassword,
                onChanged: (_) {
                  setState(() {
                    profileController.currentPasswordError = null;
                  });
                },
              ),
              const SizedBox(height: 10),

              PassTextFieldWidget(
                controller: profileController.newPasswordController,
                upText: 'New Password',
                hintText: 'Enter your new password',
                validator: profileController.validatenewPassword,
                onChanged: (_) {
                  setState(() {
                    profileController.newPasswordError = null;
                  });
                },
              ),
              const SizedBox(height: 10),

              PassTextFieldWidget(
                controller: profileController.confirmPasswordController,
                upText: 'Confirm Password',
                hintText: 'Confirm your new password',
                validator: (value) => profileController.validateconfirmPassword(
                  value,
                  profileController.newPasswordController.text,
                ),
                onChanged: (_) {
                  setState(() {
                    profileController.confirmPasswordError = null;
                  });
                },
              ),

              const SizedBox(height: 30),

              // Send button
              ButtonWidget(
                text: "SEND",
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _showConfirmationDialog();
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

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
            "Confirm Change Password",
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
                "Are you sure you want to change the password?",
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
                  onPressed: () async {
                    await profileController.sendChangePassword(context);
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
