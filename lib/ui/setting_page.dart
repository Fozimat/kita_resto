import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kita_resto/preferences/settings_preferences.dart';
import 'package:kita_resto/provider/scheduling_provider.dart';
import 'package:kita_resto/provider/settings_provider.dart';
import 'package:kita_resto/widget/custom_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatelessWidget {
  static const routeName = 'settings';

  const SettingPage({super.key});

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
      body: ChangeNotifierProvider<SettingsProvider>(
        create: (_) => SettingsProvider(
          settingsPreferences: SettingsPreferences(
            sharedPreferences: SharedPreferences.getInstance(),
          ),
        ),
        child: Consumer<SettingsProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
              child: ListTile(
                title: const Text('Restaurant Notification'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: provider.isSwitchActive,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          scheduled.scheduledRestaurant(value);
                          provider.enableReminder(value);
                        }
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
