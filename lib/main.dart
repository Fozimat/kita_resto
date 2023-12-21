import 'package:flutter/material.dart';
import 'package:kita_resto/ui/detail_page.dart';
import 'package:kita_resto/ui/list_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Kita Resto',
        initialRoute: RestaurantListPage.routeName,
        routes: {
          RestaurantListPage.routeName: (context) => const RestaurantListPage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              id: ModalRoute.of(context)?.settings.arguments as String)
        });
  }
}
