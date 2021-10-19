import 'package:flutter/material.dart';
import 'package:restaurant_app/pages/detail_restaurant.dart';
import 'package:restaurant_app/pages/restaurant_page.dart';
import 'package:restaurant_app/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        RestaurantPage.routeName: (context) => RestaurantPage(),
        DetailRestaurantPage.routeName: (context) => DetailRestaurantPage(
              idRestaurant:
                  ModalRoute.of(context)?.settings.arguments as String,
            )
      },
    );
  }
}
