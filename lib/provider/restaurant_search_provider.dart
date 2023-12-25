import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kita_resto/data/api/api_service.dart';
import 'package:kita_resto/data/model/restaurant_search.dart';
import 'package:kita_resto/utils/result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  late ResultState _state;

  RestaurantSearchProvider({required this.apiService}) {
    _fetchRestaurant(search);
  }

  late RestaurantSearchResult _restaurantSearchResult;

  String _message = '';
  String get message => _message;

  String _search = '';
  String get search => _search;

  RestaurantSearchResult get result => _restaurantSearchResult;
  ResultState get state => _state;

  Future<dynamic> _fetchRestaurant(search) async {
    try {
      if (search.isEmpty) {
        _state = ResultState.noData;
        _message = 'Start your search by entering a keyword';
        notifyListeners();
        return;
      }

      _state = ResultState.loading;
      notifyListeners();

      final restaurant = await apiService.getSearchRestaurant(search);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantSearchResult = restaurant;
      }
    } catch (e) {
      if (e is SocketException) {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'No Internet Connection';
      } else if (e is TimeoutException) {
        _state = ResultState.error;
        notifyListeners();
        return _message = "Timeout exception";
      } else {
        _state = ResultState.error;
        notifyListeners();
        return _message = "Unhandled exception";
      }
    }
  }

  void updateSearch(String query) {
    _search = query;
    _fetchRestaurant(_search);
  }
}
