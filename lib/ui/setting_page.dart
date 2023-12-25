import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  static const routeName = 'settings';

  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isNotification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Restaurant Notification',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                Switch(
                  value: isNotification,
                  onChanged: (bool value) {
                    setState(() {
                      isNotification = value;
                    });
                  },
                ),
              ],
            ),
            const Text(
              'Enable Notification',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
