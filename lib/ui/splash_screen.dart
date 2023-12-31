import 'package:flutter/material.dart';
import 'package:kita_resto/ui/home_page.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splash_screen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: FlutterLogo(size: 100),
          ),
          Text(
            "Kita Resto",
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
