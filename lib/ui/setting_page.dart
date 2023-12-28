import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kita_resto/provider/scheduling_provider.dart';
import 'package:kita_resto/widget/custom_dialog.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  static const routeName = 'settings';

  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Resto'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.0, left: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recommendation restaurants for you!',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.white70),
              ),
            ),
          ),
        ),
      ),
      body: ChangeNotifierProvider<SchedulingProvider>(
        create: (_) => SchedulingProvider(),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
          child: ListTile(
            title: const Text('Scheduling News'),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, scheduled, _) {
                return Switch.adaptive(
                  value: scheduled.isScheduled,
                  onChanged: (value) async {
                    if (Platform.isIOS) {
                      customDialog(context);
                    } else {
                      scheduled.scheduledRestaurant(value);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
