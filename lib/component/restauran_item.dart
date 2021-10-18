import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/pages/detail_restaurant.dart';

Widget restaurantItem(BuildContext context, Restaurant restaurant) {
  return Card(
      child: InkWell(
    onTap: () {
      // Navigator.pushNamed(context, DetailRestaurant.routeName,
      //     arguments: restaurant);
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag: restaurant.pictureId,
                child: Image.network(ApiService.baseUrlPictureMedium+
                  restaurant.pictureId,
                  width: 100,
                  height: 80,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding:
                  const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  Row(children: [
                    const Icon(
                      Icons.maps_home_work_rounded,
                      size: 16.0,
                      color: Colors.grey,
                    ),
                    Text(
                      " ${restaurant.city}",
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.grey),
                    )
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(top:16.0, bottom: 8.0),
                    child: Row(children: [
                      RatingBarIndicator(
                        rating: restaurant.rating,
                        itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber,),
                        itemCount: 5,
                        itemSize: 16.0,
                        direction: Axis.horizontal,
                      ),
                      Text(" ${restaurant.rating.toString()}")
                    ],),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  ));
}
