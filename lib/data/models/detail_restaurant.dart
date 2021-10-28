

import 'package:json_annotation/json_annotation.dart';

part 'detail_restaurant.g.dart';

@JsonSerializable()
class DetailRestaurant {
  DetailRestaurant({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  bool error;
  String message;
  ContentDetailRestaurant restaurant;

  factory DetailRestaurant.fromJson(Map<String, dynamic> json) => _$DetailRestaurantFromJson(json);
}

@JsonSerializable()
class ContentDetailRestaurant {
  ContentDetailRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Category>? categories;
  Menus? menus;
  dynamic rating;
  List<CustomerReview>? customerReviews;

  factory ContentDetailRestaurant.fromJson(Map<String, dynamic> json) => _$ContentDetailRestaurantFromJson(json);
  Map<String, dynamic> toJson(restaurant) => _$ContentDetailRestaurantToJson(restaurant);

}

@JsonSerializable()
class Category {
  Category({
    required this.name,
  });

  String name;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
}

@JsonSerializable()
class CustomerReview {
  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  String name;
  String review;
  String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => _$CustomerReviewFromJson(json);
}

@JsonSerializable()
class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  List<Category> foods;
  List<Category> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => _$MenusFromJson(json);
}
