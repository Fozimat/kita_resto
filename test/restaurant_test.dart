import 'package:flutter_test/flutter_test.dart';
import 'package:kita_resto/data/model/restaurant.dart';
import 'package:kita_resto/provider/restaurants_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:kita_resto/data/api/api_service.dart';
import 'package:mockito/mockito.dart';

import 'restaurant_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  var restaurantList = {
    "id": "rqdv5juczeskfw1e867",
    "name": "Melting Pot",
    "description":
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
    "pictureId": "14",
    "city": "Medan",
    "rating": 4.2
  };

  var response = {
    "error": false,
    "message": "success",
    "count": 20,
    "restaurants": [
      {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description":
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
        "pictureId": "14",
        "city": "Medan",
        "rating": 4.2
      },
      {
        "id": "s1knt6za9kkfw1e867",
        "name": "Kafe Kita",
        "description":
            "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
        "pictureId": "25",
        "city": "Gorontalo",
        "rating": 4
      }
    ]
  };

  final client = MockApiService();

  test('Check parsing JSON data from mock up api restaurant', () async {
    when(client.getRestaurant()).thenAnswer(
        (invoke) async => Future.value(RestaurantResult.fromJson(response)));

    RestaurantsProvider restaurantsProvider =
        RestaurantsProvider(apiService: client);

    await restaurantsProvider.apiService.getRestaurant();

    var result = restaurantsProvider.result.restaurants[0].name ==
        Restaurant.fromJson(restaurantList).name;

    expect(result, true);
  });
}
