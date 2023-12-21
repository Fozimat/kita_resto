import 'package:flutter/material.dart';
import 'package:kita_resto/data/api/api_service.dart';
import 'package:kita_resto/data/model/restaurant_detail.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant/detail';

  final String id;

  const RestaurantDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  late Future<RestaurantDetailResult> _restaurantDetail;

  @override
  void initState() {
    super.initState();
    _restaurantDetail = ApiService().getDetailRestaurant(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<RestaurantDetailResult>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.restaurant.name);
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return const Text('Loading');
          },
          future: _restaurantDetail,
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<RestaurantDetailResult>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Restaurant restaurant = snapshot.data!.restaurant;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                      '${ApiService.getSmallImageUrl()}/${restaurant.pictureId}'),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          child: Text(
                            restaurant.name,
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
                                  fontSize: 15.0, fontWeight: FontWeight.w600),
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
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    padding: const EdgeInsets.all(12.0),
                                  ),
                                  child:
                                      Text(restaurant.menus.foods[index].name),
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
                                  child:
                                      Text(restaurant.menus.drinks[index].name),
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
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: _restaurantDetail,
      ),
    );
  }
}
