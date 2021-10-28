import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/component/loading_item.dart';
import 'package:restaurant_app/component/restauran_item.dart';
import 'package:restaurant_app/provider/database_provider.dart';

class FavouritePage extends StatelessWidget {
  static const String routeName = "/favourite-page";

  const FavouritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favourite Restaurant"),),
      body: Consumer<DatabaseProvider>(
        builder: (context,provider, child){
          if(provider.restaurant.isEmpty){
            return const ErrorOrNoData(type: 'nodata');
          }else {
            return ListView.builder(
                itemCount: provider.restaurant.length,
                padding: const EdgeInsets.all(5.0),
                itemBuilder: (context, index) {
                  return restaurantItem(
                      context, provider.restaurant[index]);
                }
            );
          }
        },
      )
    );
  }
}
