import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:restaurant_app/component/loading_item.dart';
import 'package:restaurant_app/component/restauran_item.dart';
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
  void initState() {
    Provider.of<RestaurantProvider>(context, listen: false).getRestaurant();
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
                return errorOrNoData("nodata");
              case LoadingState.HasData:
                return SmartRefresher(
                  enablePullDown: true,
                  onRefresh: () {
                    state.getRestaurant();
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
                return errorOrNoData("error");
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
          onChanged: (text) {
            // text = text.toLowerCase();
            // setState(() {
            //   _restaurantForDisplay = _restaurant.where((rest) {
            //     var restaurantName = rest.name.toLowerCase();
            //     return restaurantName.contains(text);
            //   }).toList();
            // });
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
    ));
  }
}
