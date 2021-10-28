import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:restaurant_app/component/home_appbar.dart';
import 'package:restaurant_app/component/loading_item.dart';
import 'package:restaurant_app/component/restauran_item.dart';
import 'package:restaurant_app/component/shimmer_restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/utils/loading.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  static const routeName = '/restaurant';

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            Consumer<RestaurantProvider>(builder: (context, provider, _) {
              return sliverAppBar(context,provider);
            })
          ];
        },
        body: Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            switch (state.loadingState) {
              case LoadingState.Loading:
                return ListView.builder(
                  padding: const EdgeInsets.all(5.0),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return buildShimmerRestaurantList();
                  },
                );
              case LoadingState.NoData:
                return const ErrorOrNoData(type: "nodata");
              case LoadingState.HasData:
                return SmartRefresher(
                  enablePullDown: true,
                  onRefresh: () {
                    state.getRestaurants();
                    _refreshController.refreshCompleted();
                  },
                  controller: _refreshController,
                  child: ListView.builder(
                      itemCount: state.listRestaurant.restaurants.length,
                      padding: const EdgeInsets.all(5.0),
                      itemBuilder: (context, index) {
                        return restaurantItem(
                            context, state.listRestaurant.restaurants[index]);
                      }),
                );
              case LoadingState.Error:
                return ErrorOrNoData(
                    type: "error",
                    buttonTap: () {
                      state.getRestaurants();
                    });
            }
          },
        ),
      ),
    );
  }
}
