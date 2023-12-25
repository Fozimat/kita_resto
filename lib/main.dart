import 'package:flutter/material.dart';
import 'package:kita_resto/ui/detail_page.dart';
import 'package:kita_resto/ui/favorite_page.dart';
import 'package:kita_resto/ui/list_page.dart';
import 'package:kita_resto/ui/search_page.dart';
import 'package:kita_resto/ui/setting_page.dart';
import 'package:kita_resto/ui/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kita Resto',
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        RestaurantListPage.routeName: (context) => const RestaurantListPage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
            id: ModalRoute.of(context)?.settings.arguments as String),
        RestaurantSearchPage.routeName: (context) =>
            const RestaurantSearchPage(),
        FavoritePage.routeName: (context) => const FavoritePage(),
        SettingPage.routeName: (context) => const SettingPage(),
      },
    );
  }
}
