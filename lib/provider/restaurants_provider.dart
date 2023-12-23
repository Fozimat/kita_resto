import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kita_resto/data/api/api_service.dart';
import 'package:kita_resto/data/model/restaurant.dart';
import 'package:kita_resto/utils/enum_result.dart';

class RestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantsProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantResult _restaurantsResult;
  late ResultState _state;

  String _message = '';
  String get message => _message;

  RestaurantResult get result => _restaurantsResult;
  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = restaurant;
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
}
