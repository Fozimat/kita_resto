import 'package:flutter/material.dart';
import 'package:kita_resto/preferences/settings_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsPreferences settingsPreferences;

  SettingsProvider({required this.settingsPreferences}) {
    _getRestaurantPreferences();
  }

  bool _isSwitchActive = false;
  bool get isSwitchActive => _isSwitchActive;

  void _getRestaurantPreferences() async {
    _isSwitchActive = await settingsPreferences.isReminderActive;
    notifyListeners();
  }

  void enableReminder(bool value) {
    settingsPreferences.setReminderResto(value);
    _getRestaurantPreferences();
  }
}
