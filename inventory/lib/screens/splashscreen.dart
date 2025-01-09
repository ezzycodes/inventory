// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:inventory/screens/auth_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
      backgroundColor: const Color(0xFF004aad),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(child: _topImageSection()),
          _spashButton(context),
           ],
          ),
        ),
      ),
    );
  }
}

Widget _topImageSection() {
  return Center(
    child: Image.asset(
    "assets/images/splashscreen1.jpg")
    );
}

Widget _spashButton(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          side: BorderSide(
            width: 2.0,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  AuthPage()),
          );
        },
        child: const Icon(Icons.arrow_forward),
      ),
    ],
  );
}
