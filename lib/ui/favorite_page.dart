import 'package:flutter/material.dart';
import 'package:kita_resto/data/api/api_service.dart';
import 'package:kita_resto/provider/database_provider.dart';
import 'package:kita_resto/ui/detail_page.dart';
import 'package:kita_resto/utils/result_state.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  static const routeName = '/favorite';

  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Resto'),
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
      body: Consumer<DatabaseProvider>(
        builder: (context, databaseProvider, _) {
          if (databaseProvider.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (databaseProvider.state == ResultState.hasData) {
            if (databaseProvider.bookmarks.isEmpty) {
              return const Center(child: Text('No favorite restaurants.'));
            }
            return ListView.builder(
              itemCount: databaseProvider.bookmarks.length,
              itemBuilder: (context, index) {
                var restaurant = databaseProvider.bookmarks[index];
                return FutureBuilder<bool>(
                  future: databaseProvider.isBookmarked(restaurant.id),
                  builder: (context, snapshot) {
                    var isBookmarked = snapshot.data ?? false;
                    return Material(
                      child: ListTile(
                        trailing: isBookmarked
                            ? IconButton(
                                onPressed: () => databaseProvider
                                    .removeBookmark(restaurant.id),
                                icon: const Icon(Icons.favorite),
                                color: Colors.red,
                              )
                            : IconButton(
                                onPressed: () =>
                                    databaseProvider.addBookmark(restaurant),
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
            );
          } else if (databaseProvider.state == ResultState.noData) {
            return const Center(child: Text('No favorite restaurants.'));
          } else if (databaseProvider.state == ResultState.error) {
            return Center(child: Text(databaseProvider.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
