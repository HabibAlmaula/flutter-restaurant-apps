import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/component/restauran_item.dart';
import 'package:restaurant_app/data/models/restaurant.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  static const routeName = '/restaurant';

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  final List<Restaurant> _restaurant = <Restaurant>[];
  List<Restaurant> _restaurantForDisplay = <Restaurant>[];

  Future<String> _fetchRestaurantAssets() async {
    return DefaultAssetBundle.of(context)
        .loadString("assets/json/restaurant.json");
  }

  Future<List<Restaurant>> loadRestaurant() async {
    String jsonAsset = await _fetchRestaurantAssets();
    final restaurantData = Restaurants.fromJson(jsonDecode(jsonAsset));
    return restaurantData.listRestaurant;
  }

  @override
  void initState() {
    loadRestaurant().then((value) {
      setState(() {
        _restaurant.addAll(value);
        _restaurantForDisplay = _restaurant;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [sliverAppBar()];
        },
        body: ListView.builder(
          itemCount: _restaurantForDisplay.length,
          padding: const EdgeInsets.all(5.0),

          itemBuilder: (context, index) {
          return restaurantItem(context, _restaurantForDisplay[index]);
        }),
      ),
    );
  }

  SliverAppBar sliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      backgroundColor: Colors.redAccent,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          background: Image.asset(
        "assets/images/fast_food.jpeg",
        fit: BoxFit.fitWidth,
      )),
      title: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                offset: const Offset(1.1, 1.1),
                blurRadius: 5.0),
          ],
        ),
        child: CupertinoTextField(
          // controller: _filter,
          onChanged: (text) {
            text = text.toLowerCase();
            setState(() {
              _restaurantForDisplay = _restaurant.where((rest) {
                var restaurantName = rest.name.toLowerCase();
                return restaurantName.contains(text);
              }).toList();
            });
          },
          keyboardType: TextInputType.text,
          placeholder: 'Search',
          placeholderStyle: const TextStyle(
            color: Color(0xffC4C6CC),
            fontSize: 14.0,
            fontFamily: 'Brutal',
          ),
          prefix: const Padding(
            padding: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
            child: Icon(
              Icons.search,
              size: 18,
              color: Colors.black,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
