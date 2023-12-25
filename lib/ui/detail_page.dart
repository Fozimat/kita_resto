import 'package:flutter/material.dart';
import 'package:kita_resto/data/api/api_service.dart';
import 'package:kita_resto/data/model/restaurant_detail.dart';
import 'package:kita_resto/provider/restaurant_detail_provider.dart';
import 'package:kita_resto/utils/result_state.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant/detail';

  final String id;

  const RestaurantDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ChangeNotifierProvider(
          create: (context) =>
              RestaurantDetailProvider(apiService: ApiService(), id: id),
          child: Consumer<RestaurantDetailProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const Text('Loading...');
              } else if (state.state == ResultState.hasData) {
                return Text(state.result.restaurant!.name);
              }
              return const Text('Loading');
            },
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ChangeNotifierProvider(
        create: (context) =>
            RestaurantDetailProvider(apiService: ApiService(), id: id),
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.hasData) {
              Restaurant? restaurant = state.result.restaurant;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                        '${ApiService.getSmallImageUrl()}/${restaurant?.pictureId}'),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40,
                            child: Text(
                              restaurant!.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0,
                                  color: Colors.blue),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 24.0,
                              ),
                              const SizedBox(width: 8.0),
                              Text(restaurant.city,
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.red,
                                size: 24.0,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                restaurant.rating.toString(),
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          const Divider(height: 1.0),
                          const SizedBox(height: 8.0),
                          Text(restaurant.description),
                          const SizedBox(height: 8.0),
                          const Divider(height: 1.0),
                          const SizedBox(height: 8.0),
                          const Text(
                            'Menus',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                          const Text('Foods:'),
                          SizedBox(
                            height: 50.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: restaurant.menus.foods.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      padding: const EdgeInsets.all(12.0),
                                    ),
                                    child: Text(
                                        restaurant.menus.foods[index].name),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Text('Drinks:'),
                          SizedBox(
                            height: 50.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: restaurant.menus.drinks.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        padding: const EdgeInsets.all(12.0)),
                                    child: Text(
                                        restaurant.menus.drinks[index].name),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
