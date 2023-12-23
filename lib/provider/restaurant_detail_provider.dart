import 'package:flutter/material.dart';
import 'package:kita_resto/data/api/api_service.dart';
import 'package:kita_resto/data/model/restaurant_detail.dart';
import 'package:kita_resto/utils/enum_result.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchDetailRestaurant(id);
  }

  late RestaurantDetailResult _restaurantDetailResult;
  late ResultState _state;

  String _message = '';
  String get message => _message;

  RestaurantDetailResult get result => _restaurantDetailResult;
  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurantDetail = await apiService.getDetailRestaurant(id);

      if (restaurantDetail.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetailResult = restaurantDetail;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
