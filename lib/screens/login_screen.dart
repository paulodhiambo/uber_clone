import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
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
                TextButton.icon(
                  style: TextButton.styleFrom(primary: Colors.blue),
                  icon: Icon(
                    Icons.login,
                  ),
                  onPressed: () {
                    print("Button Pressed");
                  },
                  label: Text(
                    "Login",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
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
}
