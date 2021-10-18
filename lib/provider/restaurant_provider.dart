import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/models/detailrestaurant.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/utils/loading.dart';

class RestaurantProvider extends ChangeNotifier {
  late Restaurants _listRestaurant;
  late DetailRestaurant _detailRestaurant;
  late String _message;
  late LoadingState _loadingState;

  Restaurants get listRestaurant => _listRestaurant;
  DetailRestaurant get detailRestaurant => _detailRestaurant;
  String get message => _message;
  LoadingState get loadingState => _loadingState;

  Future<dynamic> getRestaurant() async {
    try {
      _loadingState = LoadingState.Loading;
      notifyListeners();

      final restaurant = await ApiService().getListRestaurants();
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

  Future<dynamic> getDetailRestaurant(String id) async {
    try {
      _loadingState = LoadingState.Loading;
      notifyListeners();
      final detailRestaurant = await ApiService().getDetailRestaurant(id);
      _loadingState = LoadingState.HasData;
      notifyListeners();
      return _detailRestaurant = detailRestaurant;
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

  Future<dynamic> searchRestaurant(String query) async {
    try {
      // _loadingState = LoadingState.Loading;
      // notifyListeners();
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
