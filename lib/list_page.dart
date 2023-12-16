import 'package:flutter/material.dart';
import 'package:kita_resto/detail_page.dart';
import 'package:kita_resto/restaurant.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kita Resto'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.0, left: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recommendation restaurants for you!',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<Restaurant> restaurants = parseRestaurants(snapshot.data);

          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final Restaurant restaurant = restaurants[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(restaurant.pictureId),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(restaurant.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(restaurant.city),
                        Text('Rating: ${restaurant.rating}'),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                          context, RestaurantDetailPage.routeName,
                          arguments: restaurant);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
