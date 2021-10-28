import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/models/detail_restaurant.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/utils/loading.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  late Restaurants _listRestaurant;
  late DetailRestaurant _detailRestaurant;
  String _message = "";
  LoadingState _loadingState = LoadingState.Loading;

  RestaurantProvider({required this.apiService});

  Restaurants get listRestaurant => _listRestaurant;
  DetailRestaurant get detailRestaurant => _detailRestaurant;
  String get message => _message;
  LoadingState get loadingState => _loadingState;

  RestaurantProvider getRestaurants() {
    _getRestaurant();
    return this;
  }

  RestaurantProvider getDetailRestaurant(String id) {
    _getDetailRestaurant(id);
    return this;
  }

  RestaurantProvider searchRestaurant(String query) {
    _searchRestaurant(query);
    return this;
  }

  Future<dynamic> _getRestaurant() async {
    try {
      _loadingState = LoadingState.Loading;
      notifyListeners();
      final restaurant = await apiService.getListRestaurants();
      if (restaurant.restaurants.isEmpty) {
        _loadingState = LoadingState.NoData;
        notifyListeners();
        return _message = "Tidak ada data untuk ditampilkan";
      } else {
        _loadingState = LoadingState.HasData;
        notifyListeners();
        return _listRestaurant = restaurant;
      }
    } catch (e) {
      _loadingState = LoadingState.Error;
      notifyListeners();
      _message = "Error ==> $e";
    }
  }

  Future<dynamic> _getDetailRestaurant(String id) async {
    try {
      _loadingState = LoadingState.Loading;
      notifyListeners();
      final dataDetailRestaurant = await ApiService().getDetailRestaurant(id);
      if (dataDetailRestaurant.error) {
        _loadingState = LoadingState.NoData;
        notifyListeners();
      } else {
        _loadingState = LoadingState.HasData;
        notifyListeners();
        return _detailRestaurant = dataDetailRestaurant;
      }
    } catch (e) {
      if (e.toString().contains('404')) {
        _loadingState = LoadingState.NoData;
        notifyListeners();
        return _message = "Tidak ada data untuk ditampilkan";
      } else {
        _loadingState = LoadingState.Error;
        notifyListeners();
        _message = "Error ==> $e";
      }
    }
  }

  Future<dynamic> _searchRestaurant(String query) async {
    try {
      _loadingState = LoadingState.Loading;
      notifyListeners();
      final resultRestaurant = await ApiService().searchRestaurant(query);
      if (resultRestaurant.restaurants.isEmpty) {
        _loadingState = LoadingState.NoData;
        notifyListeners();
        return _message = "Tidak ada data untuk ditampilkan";
      } else {
        _loadingState = LoadingState.HasData;
        notifyListeners();
        return _listRestaurant = resultRestaurant;
      }
    } catch (e) {
      _loadingState = LoadingState.Error;
      notifyListeners();
      _message = "Error ==> $e";
    }
  }
}
