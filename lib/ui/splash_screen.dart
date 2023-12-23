import 'package:flutter/material.dart';
import 'dart:async';

import 'package:kita_resto/ui/list_page.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splash_screen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacementNamed(context, RestaurantListPage.routeName);
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
