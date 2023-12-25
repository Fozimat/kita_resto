import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = '/favorite';

  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Favorite Page')),
    );
  }
}
