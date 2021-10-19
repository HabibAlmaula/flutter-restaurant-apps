// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detailrestaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailRestaurant _$DetailRestaurantFromJson(Map<String, dynamic> json) =>
    DetailRestaurant(
      error: json['error'] as bool,
      message: json['message'] as String,
      restaurant:
          Restaurant.fromJson(json['restaurant'] as Map<String, dynamic>),
    );


Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => Restaurant(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      city: json['city'] as String,
      address: json['address'] as String,
      pictureId: json['pictureId'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      menus: Menus.fromJson(json['menus'] as Map<String, dynamic>),
      rating: json['rating'] as dynamic,
      customerReviews: (json['customerReviews'] as List<dynamic>)
          .map((e) => CustomerReview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );


Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      name: json['name'] as String,
    );


CustomerReview _$CustomerReviewFromJson(Map<String, dynamic> json) =>
    CustomerReview(
      name: json['name'] as String,
      review: json['review'] as String,
      date: json['date'] as String,
    );


Menus _$MenusFromJson(Map<String, dynamic> json) => Menus(
      foods: (json['foods'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      drinks: (json['drinks'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

