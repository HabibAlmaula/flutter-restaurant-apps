import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/component/restauran_item.dart';
import 'package:restaurant_app/data/models/detail_restaurant.dart';

import 'circular_modal.dart';
import 'content_modal.dart';

Widget mainContentDetail(BuildContext context,DetailRestaurant detailRestaurant){
  return ListView(
    padding: const EdgeInsets.all(10.0),
    children: [
      Column(
        children: [
          Card(
            elevation: 7,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    detailRestaurant.restaurant.name,
                    style: GoogleFonts.fjallaOne(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 20.0,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 1,
                        ),
                        Text(
                          detailRestaurant.restaurant.city,
                          style: const TextStyle(
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    detailRestaurant.restaurant.address,
                    style: const TextStyle(fontSize: 13.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        spacing: 6.0,
                        runSpacing: 6.0,
                        children: [
                          for (var i
                          in detailRestaurant.restaurant.categories!)
                            buildChip(i.name)
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: const Text(
                      "Description",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 20.0),
                    child: Text(
                      detailRestaurant.restaurant.description,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              "Menu",
              style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  margin: const EdgeInsets.only(
                      right: 16.0, left: 16.0, top: 20.0),
                  child: InkWell(
                    onTap: () {
                      showAvatarModalBottomSheet(
                          title: "food",
                          context: context,
                          builder: (context) {
                            List<String> listContent = [];
                            for (var element in detailRestaurant
                                .restaurant.menus!.foods) {
                              listContent.add(element.name);
                            }
                            return ModalContent(
                                title: "Food", content: listContent);
                          });
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              8.0, 8.0, 8.0, 0.0),
                          child: Image.asset(
                            "assets/images/food.png",
                            width: 100,
                            height: 100,
                          ),
                        ),
                        const Padding(
                          padding:
                          EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                          child: Text(
                            "Foods",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  margin: const EdgeInsets.only(
                      right: 16.0, left: 16.0, top: 20.0),
                  child: InkWell(
                    onTap: () {
                      showAvatarModalBottomSheet(
                          title: "drink",
                          context: context,
                          builder: (context) {
                            List<String> listContent = [];
                            for (var element in detailRestaurant
                                .restaurant.menus!.drinks) {
                              listContent.add(element.name);
                            }
                            return ModalContent(
                                title: "Drink", content: listContent);
                          });
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              8.0, 8.0, 8.0, 0.0),
                          child: Image.asset(
                            "assets/images/drink.png",
                            width: 100,
                            height: 100,
                          ),
                        ),
                        const Padding(
                          padding:
                          EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                          child: Text(
                            "Drinks",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      )
    ],
  );
}