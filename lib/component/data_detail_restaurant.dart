import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flash/flash.dart';
import 'package:restaurant_app/component/main_content_detail.dart';
import 'package:restaurant_app/data/models/detail_restaurant.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/provider/database_provider.dart';

class DataDetail extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  static const double kExpandedHeight = 200;
  final DetailRestaurant detailRestaurant;

  DataDetail({Key? key, required this.detailRestaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var restaurant = detailRestaurant.restaurant;

    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, isScroleld) {
        return [
          SliverAppBar(
            pinned: true,
            expandedHeight: kExpandedHeight,
            flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              var top = constraints.biggest.height;

              return FlexibleSpaceBar(
                background: Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                    ApiService.baseUrlPictureLarge + restaurant.pictureId,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                title: Text(
                  top > 71 && top < 91 ? restaurant.name : "",
                ),
                titlePadding: EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: _horizontalTitlePadding + 16.0),
              );
            }),
          )
        ];
      },
      body: Stack(
        children: [
          mainContentDetail(context, detailRestaurant),
          Positioned(
            right: 10,
            top: -30,
            child: Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: Consumer<DatabaseProvider>(
                builder: (context, provider, child) {
                  return FutureBuilder<bool>(
                    future: provider.isFavourite(restaurant.id),
                    builder: (context, snapshot) {
                      var isFavourite = snapshot.data ?? false;
                      debugPrint("IS FAVORITE BEFORE BUTTON : $isFavourite");

                      return ElevatedButton(
                        onPressed: () {
                          var data = Restaurant(
                              id: restaurant.id,
                              name: restaurant.name,
                              description: restaurant.description,
                              pictureId: restaurant.pictureId,
                              city: restaurant.city,
                              rating: restaurant.rating.toDouble());

                          isFavourite
                              ? provider.removeFavourite(
                                  detailRestaurant.restaurant.id)
                              : provider.addFavourite(data);

                          debugPrint("IS FAVORITE AFTER BUTTON : $isFavourite");
                          context.showSuccessBar(
                            content: isFavourite
                                ? Text("Berhasil menghapus " + restaurant.name)
                                : Text("Berhasil menyimpan " + restaurant.name),
                          );
                        },
                        child: Icon(Icons.favorite_rounded,
                            color: (isFavourite) ? Colors.pink : Colors.white),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                          primary: Colors.blue, // <-- Button color
                          onPrimary: Colors.red, // <-- Splash color
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  double get _horizontalTitlePadding {
    const kBasePadding = 15.0;
    const kMultiplier = 0.5;

    if (_scrollController.hasClients) {
      if (_scrollController.offset < (kExpandedHeight / 2)) {
        return kBasePadding;
      }

      if (_scrollController.offset > (kExpandedHeight - kToolbarHeight)) {
        return (kExpandedHeight / 2 - kToolbarHeight) * kMultiplier +
            kBasePadding;
      }

      return (_scrollController.offset - (kExpandedHeight / 2)) * kMultiplier +
          kBasePadding;
    }

    return kBasePadding;
  }
}
