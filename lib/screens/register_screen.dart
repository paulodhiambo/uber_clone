import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uber_clone/main.dart';
import 'package:uber_clone/screens/login_screen.dart';
import 'package:uber_clone/screens/main_screen.dart';

class RegisterScreen extends StatelessWidget {
  static const String idScreen = "register";
  final FirebaseAuth mAuth = FirebaseAuth.instance;
  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController phoneTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
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
              "Register as a Rider",
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
                    controller: nameTextEditingController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelStyle: GoogleFonts.inter(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      hintText: "John Doe",
                      hintStyle: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                      labelText: "Name",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                    controller: phoneTextEditingController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelStyle: GoogleFonts.inter(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      hintText: "0701234567",
                      hintStyle: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                      labelText: "Phone",
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: confirmPasswordTextEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelStyle: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                      ),
                      labelText: "Confirm password",
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
                      return registerNewUser(context);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 10.0,
                    child: Text(
                      "Register",
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
                        LoginScreen.idScreen,
                        (route) => false,
                      );
                    },
                    child: Text(
                      "Already have an account? Login",
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
      ),
    );
  }

  //Function to Register User with Email and Password
  void registerNewUser(BuildContext buildContext) async {
    if (passwordTextEditingController.text.toString().length < 6) {
      displayToast("Password should be at least 6 characters", buildContext);
    }
    if (passwordTextEditingController.text.toString() !=
        confirmPasswordTextEditingController.text.toString()) {
      displayToast("Passwords must match", buildContext);
    }
    if (phoneTextEditingController.text.toString().length != 10) {
      displayToast("Phone number must be at least 10 characters", buildContext);
    }
    if (nameTextEditingController.text.toString().length < 4) {
      displayToast("Username must be at least 4 characters", buildContext);
    }
    if (!emailTextEditingController.text.toString().contains("@")) {
      displayToast("Input a valid email address", buildContext);
    }
    final UserCredential firebaseUser = (await mAuth
        .createUserWithEmailAndPassword(
            email: emailTextEditingController.text.toString(),
            password: passwordTextEditingController.text.toString())
        .catchError((error) {
      displayToast(error.toString(), buildContext);
    }));
    if (firebaseUser.user != null) {
      //Save user info firebase realtime database if user is not null
      Map userMap = {
        "name": nameTextEditingController.text.toString().trim(),
        "email": emailTextEditingController.text.toString().trim(),
        "phone": phoneTextEditingController.text.toString().trim()
      };
      userReference.child(firebaseUser.user.uid).set(userMap);
      displayToast("User account created successfully", buildContext);
      //Navigate to the home screen
      Navigator.pushNamedAndRemoveUntil(
          buildContext, MainScreen.idScreen, (route) => false);
    } else {
      displayToast("An error occurred", buildContext);
    }
  }

  void displayToast(String message, BuildContext buildContext) {
    Fluttertoast.showToast(msg: message);
  }
}
