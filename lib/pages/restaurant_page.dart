import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/component/restauran_item.dart';
import 'package:restaurant_app/data/restaurant.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  static const routeName = '/restaurant';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [sliverAppBar()];
        },
        body: FutureBuilder<String>(
          future: DefaultAssetBundle.of(context)
              .loadString("assets/json/restaurant.json"),
          builder: (context, data) {
            if (data.connectionState != ConnectionState.waiting &&
                data.hasData) {
              final restaurant = Restaurants.fromJson(jsonDecode(data.data!));

              return ListView.builder(
                padding: const EdgeInsets.all(5.0),
                itemCount: restaurant.listRestaurant.length,
                itemBuilder: (context, index) {
                  Restaurant restItem = restaurant.listRestaurant[index];
                  return restaurantItem(context, restItem);
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
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
