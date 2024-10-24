import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final LoginController loginController = LoginController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.black,
            // padding: const EdgeInsets.only(top: 60),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'lib/image/expatlogo.png',
                    height: 100,
                    width: 200,
                  ),
                ),

                const SizedBox(height: 10),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(
                    thickness: 2,
                    color: Color.fromRGBO(114, 162, 138, 1),
                  ),
                ),

                const SizedBox(height: 20),

                //welcome back, you've been missed!
                const Center(
                  child: Text(
                    'Welcome to Expat Retail App',
                    style: TextStyle(
                      color: Color.fromRGBO(114, 162, 138, 1),
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //username textfield
                TextFieldWidget(
                  controller: loginController.usernameController,
                  upText: 'Username',
                  hintText: 'Enter your username',
                  obscureText: false,
                  validator: loginController.validateUsername,
                  onChanged: (_) {
                    setState(() {
                      loginController.usernameError = null;
                    });
                  },
                ),

                const SizedBox(height: 10),

                //password textfield
                PassTextFieldWidget(
                  controller: loginController.passwordController,
                  upText: 'Password',
                  hintText: 'Enter your password',
                  validator: loginController.validatePassword,
                  onChanged: (_) {
                    setState(() {
                      loginController.passwordError = null;
                    });
                  },
                ),

                const SizedBox(height: 40),

                //sign in button
                ButtonWidget(
                  text: "Sign In",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      loginController.handleLogin(context);
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
}
