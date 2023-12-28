import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kita_resto/common/navigation.dart';
import 'package:kita_resto/ui/detail_page.dart';
import 'package:kita_resto/ui/favorite_page.dart';
import 'package:kita_resto/ui/home_page.dart';
import 'package:kita_resto/ui/search_page.dart';
import 'package:kita_resto/ui/setting_page.dart';
import 'package:kita_resto/ui/splash_screen.dart';
import 'package:kita_resto/utils/background_service.dart';
import 'package:kita_resto/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Kita Resto',
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomePage.routeName: (context) => const HomePage(),
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
