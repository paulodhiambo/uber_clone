import 'package:flutter/material.dart';
import 'package:uber_clone/screens/login_screen.dart';
import 'package:uber_clone/screens/main_screen.dart';
import 'package:uber_clone/screens/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Taxi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginScreen.idScreen,
      routes: {
        RegisterScreen.idScreen: (context) => RegisterScreen(),
        LoginScreen.idScreen: (context) => LoginScreen(),
        MainScreen.idScreen: (context) => MainScreen(),
      },
    );
  }
}
