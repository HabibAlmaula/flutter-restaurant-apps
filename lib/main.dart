import 'package:flutter/material.dart';
import 'package:restaurant_app/data/restaurant.dart';
import 'package:restaurant_app/pages/detail_restaurant.dart';
import 'package:restaurant_app/pages/restaurant_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: RestaurantPage.routeName,
      routes: {
        RestaurantPage.routeName: (context) => const RestaurantPage(),
        DetailRestaurant.routeName: (context) => DetailRestaurant(restaurants: ModalRoute.of(context)?.settings.arguments as Restaurant,)
      },
    );
  }
}


