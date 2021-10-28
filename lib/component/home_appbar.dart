import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/component/action_menu_home.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

SliverAppBar sliverAppBar(BuildContext context, RestaurantProvider provider) {
  return SliverAppBar(
    titleSpacing: 0,
    expandedHeight: 200,
    backgroundColor: Colors.redAccent,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      background: Stack(
        children: [
          Image.asset(
            "assets/images/fast_food.jpeg",
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          Positioned(
            bottom: 80,
            left: 10,
            child: Text(
              "Find your taste here...",
              style: GoogleFonts.lobster(
                textStyle: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.white,
                      offset: Offset(5.0, 3.0),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ),
    title: Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
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
          onChanged: (text) {
            text = text.toLowerCase();
            provider.searchRestaurant(text);
          },
          keyboardType: TextInputType.text,
          placeholder: 'Search',
          placeholderStyle: const TextStyle(
            color: Color(0xffC4C6CC),
            fontSize: 14.0,
            fontFamily: 'Brutal',
          ),
          prefix: const Padding(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
            child: Icon(
              CupertinoIcons.search,
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
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: actionButtonHome(context),
      ),
    ],
  );
}
