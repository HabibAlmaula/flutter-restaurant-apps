import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/utils/loading.dart';

class DatabaseProvider extends ChangeNotifier{
  final DatabaseHelper databaseHelper;
  DatabaseProvider({required this.databaseHelper}){
    _getFavourite();
  }

  late LoadingState _loadingState;
  String _message = '';
  List<Restaurant> _restaurant = [];

  LoadingState get loadingState => _loadingState;
  String get message => _message;
  List<Restaurant> get restaurant => _restaurant;

  void _getFavourite() async{
    _restaurant = await databaseHelper.getFavouriteRestaurant();
    if(_restaurant.isNotEmpty){
      _loadingState = LoadingState.HasData;
    }else{
      _loadingState = LoadingState.NoData;
      _message = 'Empty Favourite';
    }
    notifyListeners();
  }

  void addFavourite(Restaurant restaurant) async{
    try{
      await databaseHelper.addToFavourite(restaurant);
      _getFavourite();
    }catch(e){
      _loadingState = LoadingState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  void removeFavourite(String id) async{
    try{
      await databaseHelper.removeFavourite(id);
      _getFavourite();
    }catch(e){
      _loadingState = LoadingState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavourite(String id) async{
    final favouriteRestaurant = await databaseHelper.getFavouriteById(id);
    return favouriteRestaurant.isNotEmpty;
  }

}