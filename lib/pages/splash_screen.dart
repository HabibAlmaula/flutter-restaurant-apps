import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_app/pages/restaurant_page.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  static const routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 10),
        () =>
            Navigator.pushReplacementNamed(context, RestaurantPage.routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/json/food_lottie.json",
            ),
            const Text(
              "Please wait ...",
              style: TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.w500, fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }

  
}
