// ignore_for_file: avoid_print

import 'package:shared_preferences/shared_preferences.dart';

class SettingsPreferences {
  final Future<SharedPreferences> sharedPreferences;

  SettingsPreferences({required this.sharedPreferences});
  static const reminderResto = 'REMINDER_RESTO';

  Future<bool> get isReminderActive async {
    final prefs = await sharedPreferences;
    print(prefs.getBool(reminderResto) ?? false);
    return prefs.getBool(reminderResto) ?? false;
  }

  void setReminderResto(bool value) async {
    final prefs = await sharedPreferences;
    print(prefs.setBool(reminderResto, value));
    prefs.setBool(reminderResto, value);
  }
}
