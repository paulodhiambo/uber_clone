import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uber_clone/main.dart';
import 'package:uber_clone/screens/main_screen.dart';
import 'package:uber_clone/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen = "login_screen";
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final FirebaseAuth mAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 70.0,
          ),
          Center(
            child: Container(
              height: 199,
              width: 199,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            "Login as a Rider",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: [
                TextFormField(
                  controller: emailTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelStyle: GoogleFonts.inter(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                    hintText: "username@mail.com",
                    hintStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                    labelText: "Email",
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: passwordTextEditingController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                    labelText: "Password",
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                MaterialButton(
                  color: Colors.blue,
                  padding: EdgeInsets.only(
                      left: 55.0, right: 55.0, top: 10.0, bottom: 10.0),
                  onPressed: () {
                    loginUserWithEmailAndPassword(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 10.0,
                  child: Text(
                    "Login",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RegisterScreen.idScreen,
                      (route) => false,
                    );
                  },
                  child: Text(
                    "Don't have an account? Register",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void loginUserWithEmailAndPassword(BuildContext context) async {
    if (!emailTextEditingController.text.toString().contains("@")) {
      displayToast("Input a valid email address", context);
    }
    if (passwordTextEditingController.text.toString().length < 6) {
      displayToast("Password length should be at least 6 characters", context);
    }
    final UserCredential user = (await mAuth
        .signInWithEmailAndPassword(
            email: emailTextEditingController.text.toString(),
            password: passwordTextEditingController.text.toString().trim())
        .catchError((error) {
      displayToast(error, context);
    }));
    if (user.user != null) {
      userReference.child(user.user.uid).once().then((DataSnapshot snapShot) {
        if (snapShot.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.idScreen, (route) => false);
        } else {
          mAuth.signOut();
          displayToast("No user found", context);
        }
      });
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.idScreen, (route) => false);
    } else {
      displayToast("Unable to login.", context);
    }
  }

  void displayToast(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
