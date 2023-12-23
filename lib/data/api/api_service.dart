import 'dart:convert';

import 'package:kita_resto/data/model/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:kita_resto/data/model/restaurant_detail.dart';
import 'package:kita_resto/data/model/restaurant_search.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String smallImageUrl = '$_baseUrl/images/small/';

  Future<RestaurantResult> getRestaurant() async {
    final response = await http.get(Uri.parse('$_baseUrl/list'));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get restaurant');
    }
  }

  Future<RestaurantDetailResult> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get detail restaurant');
    }
  }

  Future<RestaurantSearchResult> getSearchRestaurant(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl/search?q=$query'));
    if (response.statusCode == 200) {
      return RestaurantSearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get restaurant');
    }
  }

  static getSmallImageUrl() {
    return smallImageUrl;
  }
}
