import 'package:flutter/material.dart';
import 'package:kita_resto/data/api/api_service.dart';
import 'package:kita_resto/data/db/database_helper.dart';
import 'package:kita_resto/data/model/restaurant.dart';
import 'package:kita_resto/provider/database_provider.dart';
import 'package:kita_resto/ui/detail_page.dart';
import 'package:provider/provider.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
      child: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<bool>(
            future: provider.isBookmarked(restaurant.id),
            builder: (context, snapshot) {
              var isBookmarked = snapshot.data ?? false;
              return Material(
                child: ListTile(
                  trailing: isBookmarked
                      ? IconButton(
                          onPressed: () =>
                              provider.removeBookmark(restaurant.id),
                          icon: const Icon(Icons.favorite),
                          color: Colors.red,
                        )
                      : IconButton(
                          onPressed: () => provider.addBookmark(restaurant),
                          icon: const Icon(Icons.favorite_border),
                          color: Colors.red,
                        ),
                  contentPadding: const EdgeInsets.all(10),
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(
                            '${ApiService.getSmallImageUrl()}/${restaurant.pictureId}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(restaurant.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.red,
                          ),
                          Text(restaurant.city),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.red,
                          ),
                          Text('${restaurant.rating}'),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RestaurantDetailPage.routeName,
                      arguments: restaurant.id,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
