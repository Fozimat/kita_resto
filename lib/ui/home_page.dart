import 'package:flutter/material.dart';
import 'package:kita_resto/data/api/api_service.dart';
import 'package:kita_resto/data/db/database_helper.dart';
import 'package:kita_resto/provider/database_provider.dart';
import 'package:kita_resto/provider/restaurants_provider.dart';
import 'package:kita_resto/provider/scheduling_provider.dart';
import 'package:kita_resto/ui/detail_page.dart';
import 'package:kita_resto/ui/favorite_page.dart';
import 'package:kita_resto/ui/list_page.dart';
import 'package:kita_resto/ui/setting_page.dart';
import 'package:kita_resto/utils/notification_helper.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  final NotificationHelper _notificationHelper = NotificationHelper();

  final List<Widget> _listWidget = [
    ChangeNotifierProvider<RestaurantsProvider>(
      create: (_) => RestaurantsProvider(apiService: ApiService()),
      child: const RestaurantListPage(),
    ),
    ChangeNotifierProvider(
      create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
      child: const FavoritePage(),
    ),
    ChangeNotifierProvider<SchedulingProvider>(
      create: (_) => SchedulingProvider(),
      child: const SettingPage(),
    ),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.restaurant_menu), label: 'Restaurant'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: 'Favorite'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Settings'),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}
