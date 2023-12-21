import 'package:flutter/material.dart';
import 'package:kita_resto/data/api/api_service.dart';
import 'package:kita_resto/data/model/restaurant.dart';
import 'package:kita_resto/ui/card_restaurant.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  late Future<RestaurantResult> _restaurant;

  @override
  void initState() {
    super.initState();
    _restaurant = ApiService().getRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kita Resto'),
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
      body: FutureBuilder(
        future: _restaurant,
        builder: (context, AsyncSnapshot<RestaurantResult> snapshot) {
          var state = snapshot.connectionState;
          if (state != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurant = snapshot.data?.restaurants[index];
                    return CardRestaurant(restaurant: restaurant!);
                  });
            } else if (snapshot.hasError) {
              return Center(
                child: Material(child: Text(snapshot.error.toString())),
              );
            } else {
              return const Material(child: Text(''));
            }
          }
        },
      ),
    );
  }
}
