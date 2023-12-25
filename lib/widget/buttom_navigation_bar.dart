import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.blue,
      currentIndex: currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu), label: 'Restaurant'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      onTap: onTap,
    );
  }
}
