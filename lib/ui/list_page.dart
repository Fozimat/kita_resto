import 'package:flutter/material.dart';
import 'package:kita_resto/data/api/api_service.dart';
import 'package:kita_resto/provider/restaurants_provider.dart';
import 'package:kita_resto/widget/card_restaurant.dart';
import 'package:kita_resto/ui/search_page.dart';
import 'package:kita_resto/utils/result_state.dart';
import 'package:provider/provider.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kita Resto'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RestaurantSearchPage.routeName);
              },
              icon: const Icon(Icons.search)),
        ],
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
      body: ChangeNotifierProvider<RestaurantsProvider>(
        create: (context) => RestaurantsProvider(apiService: ApiService()),
        child: Consumer<RestaurantsProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.result.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = state.result.restaurants[index];
                  return CardRestaurant(restaurant: restaurant);
                },
              );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Material(child: Text(state.message)),
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Material(child: Text(state.message)),
              );
            } else {
              return const Center(
                child: Material(
                  child: Text(''),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
