import 'package:flutter/material.dart';

import 'loading_item.dart';

Widget buildShimmerRestaurantList() {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(child: ShimmerWidget.rectangular(height: 80.0)),
          Expanded(
            flex: 2,
            child: Padding(
              padding:
                  const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ShimmerWidget.rectangular(
                    height: 16.0,
                    width: 100,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: ShimmerWidget.rectangular(
                      height: 10.0,
                      width: 70,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: ShimmerWidget.rectangular(
                      height: 10.0,
                      width: 70,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
