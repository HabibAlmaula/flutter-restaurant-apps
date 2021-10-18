import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/pages/detail_restaurant.dart';
import 'package:restaurant_app/pages/restaurant_page.dart';
import 'package:restaurant_app/pages/splash_screen.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (context) => RestaurantProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          RestaurantPage.routeName: (context) => const RestaurantPage(),
          // DetailRestaurant.routeName: (context) => DetailRestaurant(
          //       restaurants:
          //           ModalRoute.of(context)?.settings.arguments as Restaurant,
          //     )
        },
      ),
    );
  }
}
