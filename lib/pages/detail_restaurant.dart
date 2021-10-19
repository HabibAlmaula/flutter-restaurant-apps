import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/component/circular_modal.dart';
import 'package:restaurant_app/component/content_modal.dart';
import 'package:restaurant_app/component/loading_item.dart';
import 'package:restaurant_app/component/restauran_item.dart';
import 'package:restaurant_app/data/models/detailrestaurant.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/utils/loading.dart';

class DetailRestaurantPage extends StatelessWidget {
  final String idRestaurant;

  DetailRestaurantPage({Key? key, required this.idRestaurant})
      : super(key: key);

  static const routeName = '/detail-restaurant';

  final ScrollController _scrollController = ScrollController();
  static const double kExpandedHeight = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => RestaurantProvider(apiService: ApiService())
            .getDetailRestaurant(idRestaurant),
        child: Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            switch (state.loadingState) {
              case LoadingState.Loading:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Loading Please Wait"),
                      )
                    ],
                  ),
                );
              case LoadingState.NoData:
                return const ErrorOrNoData(type: "nodata");
              case LoadingState.HasData:
                return dataDetail(context, state.detailRestaurant);
              case LoadingState.Error:
                return ErrorOrNoData(
                    type: "error",
                    buttonTap: () {
                      state.getDetailRestaurant(idRestaurant);
                    });
            }
          },
        ),
      ),
    );
  }

  Widget dataDetail(BuildContext context, DetailRestaurant detailRestaurant) {
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
                  tag: detailRestaurant.restaurant.pictureId,
                  child: Image.network(
                    ApiService.baseUrlPictureLarge +
                        detailRestaurant.restaurant.pictureId,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                title: Text(
                  top > 80 && top < 125 ? detailRestaurant.restaurant.name : "",
                ),
                titlePadding: EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: _horizontalTitlePadding + 16.0),
              );
            }),
          )
        ];
      },
      body: ListView(
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
                      Text(detailRestaurant.restaurant.name,
                          style: GoogleFonts.fjallaOne(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25.0),
                          )),
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.w300),
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
                                  in detailRestaurant.restaurant.categories)
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
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 20.0),
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
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
                                    .restaurant.menus.foods) {
                                  listContent.add(element.name);
                                }
                                return ModalContent(
                                    title: "Food", content: listContent);
                              });
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                              child: Image.asset(
                                "assets/images/food.png",
                                width: 100,
                                height: 100,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
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
                                    .restaurant.menus.drinks) {
                                  listContent.add(element.name);
                                }
                                return ModalContent(
                                    title: "Drink", content: listContent);
                              });
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                              child: Image.asset(
                                "assets/images/drink.png",
                                width: 100,
                                height: 100,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
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
      ),
    );
  }

  Widget buildShimmerRestaurantDetail() {
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
    ));
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
