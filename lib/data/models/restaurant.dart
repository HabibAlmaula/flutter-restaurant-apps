
import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurants {
  Restaurants({required this.error, required this.restaurants});
  bool error;
  List<Restaurant> restaurants;

  factory Restaurants.fromJson(Map<String, dynamic> json) => _$RestaurantsFromJson(json);
  Map<String, dynamic> toJson(restaurants) => _$RestaurantsToJson(restaurants);

}

@JsonSerializable()
class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory Restaurant.fromJson(Map<String, dynamic> json) => _$RestaurantFromJson(json);
  Map<String, dynamic> toJson(restaurant) => _$RestaurantToJson(restaurant);

}
