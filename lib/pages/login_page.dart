import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_loginout_auth/elements/my_button.dart';
import 'package:firebase_loginout_auth/elements/my_textfield.dart';
import 'package:firebase_loginout_auth/elements/square_tile.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);
      //pop the loading circle
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      print(e);
      //WRONG EMAIL
      wrongErrorMessage(e.code);
      // if (e.code == 'invalid-login-credentials') {
      //show error to user
      //   wrongErrorMessage(e.code);
      //   print("email");
      // }
    }
  }

//wrong credentials message popup
  void wrongErrorMessage(String message) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: Center(
                child: Text(
              message,
              style: TextStyle(color: Colors.white),
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              //logo
              const Icon(
                Icons.lock,
                size: 100,
              ),
              SizedBox(
                height: 50,
              ),

              //welcome back
              Text(
                "Welcome back you've been missed!",
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
              const SizedBox(
                height: 25,
              ),
              //uname txtfld
              MyTextField(
                  controller: usernameController,
                  hintText: "Username",
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),
              //pwd txtfld
              MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true),
              const SizedBox(
                height: 10,
              ),
              //forgot pwd
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey[600]),
                      )),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              //sign in button
              MyButton(
                text: "Sign In",
                onTap: signUserIn,
              ),
              const SizedBox(
                height: 50,
              ),
              //or continue with
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 3,
                    )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Or Continue with",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 3,
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              //google + apple sign in button
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(imagePath: "lib/images/apple.png"),
                  SizedBox(
                    width: 25,
                  ),
                  SquareTile(imagePath: "lib/images/google.png"),
                ],
              ),
              //not a member?register now
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Register now",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
