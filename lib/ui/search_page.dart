import 'package:flutter/material.dart';
import 'package:kita_resto/data/api/api_service.dart';
import 'package:kita_resto/data/model/restaurant_search.dart';
import 'package:kita_resto/provider/restaurant_search_provider.dart';
import 'package:kita_resto/ui/detail_page.dart';
import 'package:kita_resto/utils/result_state.dart';
import 'package:provider/provider.dart';

class RestaurantSearchPage extends StatelessWidget {
  static const routeName = '/restaurant/search';

  const RestaurantSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RestaurantSearchProvider(apiService: ApiService()),
      child: Consumer<RestaurantSearchProvider>(
        builder: (context, state, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Search'),
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(100.0),
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 24.0, right: 8.0, left: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    onChanged: (query) {
                      context
                          .read<RestaurantSearchProvider>()
                          .updateSearch(query);
                    },
                  ),
                ),
              ),
            ),
            body: _buildBody(state),
          );
        },
      ),
    );
  }

  Widget _buildBody(RestaurantSearchProvider state) {
    switch (state.state) {
      case ResultState.loading:
        return const Center(child: CircularProgressIndicator());
      case ResultState.hasData:
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.result.restaurants.length,
          itemBuilder: (context, index) {
            var restaurant = state.result.restaurants[index];
            return _buildRestaurantCard(context, restaurant);
          },
        );
      case ResultState.noData:
        return Center(
          child: _buildEmptySearchPage(),
        );
      case ResultState.error:
        return Center(
          child: Material(child: Text(state.message)),
        );
      default:
        return _buildEmptySearchPage();
    }
  }

  Widget _buildRestaurantCard(BuildContext context, Restaurant restaurant) {
    return Material(
      child: ListTile(
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
          Navigator.pushNamed(context, RestaurantDetailPage.routeName,
              arguments: restaurant.id);
        },
      ),
    );
  }

  Widget _buildEmptySearchPage() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 96.0,
            color: Colors.blue,
          ),
          SizedBox(height: 16.0),
          Text('Your search result is empty'),
        ],
      ),
    );
  }
}
