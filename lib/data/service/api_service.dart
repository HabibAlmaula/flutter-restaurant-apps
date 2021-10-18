import 'dart:convert';

import 'package:restaurant_app/data/models/detailrestaurant.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:http/http.dart' as http;

class ApiService{
  static const _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const baseUrlPictureSmall = 'https://restaurant-api.dicoding.dev/images/small/';
  static const baseUrlPictureMedium = 'https://restaurant-api.dicoding.dev/images/medium/';
  static const baseUrlPictureLarge = 'https://restaurant-api.dicoding.dev/images/large/';


  Future<Restaurants> getListRestaurants() async{
    final response = await http.get(Uri.parse(_baseUrl+'list'));
    if(response.statusCode == 200) {
      return Restaurants.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load data');
    }
  }

  Future<DetailRestaurant> getDetailRestaurant(String id) async{
    final response = await http.get(Uri.parse(_baseUrl+'detail/$id'));
    var statusCode = response.statusCode;
    switch(statusCode){
      case 200:{
        return DetailRestaurant.fromJson(jsonDecode(response.body));
      }
      case 404:{
        throw Exception('$statusCode Data Not found');
      }
      default:
        throw Exception('$statusCode Failed to load data');
    }
  }
  
  Future<Restaurants> searchRestaurant(String query)async{
    final response = await http.get(Uri.parse(_baseUrl+'search?q=$query'));
    if(response.statusCode ==200){
      return Restaurants.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load data');
    }
  }
}