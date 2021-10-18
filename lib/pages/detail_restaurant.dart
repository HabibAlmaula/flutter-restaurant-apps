// import 'package:flutter/material.dart';
// import 'package:restaurant_app/component/circular_modal.dart';
// import 'package:restaurant_app/component/content_modal.dart';
// import 'package:restaurant_app/data/models/restaurant.dart';
//
// class DetailRestaurant extends StatefulWidget {
//   final Restaurant restaurants;
//
//   // ignore: use_key_in_widget_constructors
//   const DetailRestaurant({required this.restaurants});
//
//   static const routeName = '/detail-restaurant';
//
//   @override
//   State<DetailRestaurant> createState() => _DetailRestaurantState();
// }
//
// class _DetailRestaurantState extends State<DetailRestaurant> {
//   late ScrollController _scrollController;
//   static const double kExpandedHeight = 200;
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController()..addListener(() => setState(() {}));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: NestedScrollView(
//         controller: _scrollController,
//         headerSliverBuilder: (context, isScroleld) {
//           return [
//             SliverAppBar(
//               pinned: true,
//               expandedHeight: kExpandedHeight,
//               flexibleSpace: LayoutBuilder(
//                   builder: (BuildContext context, BoxConstraints constraints) {
//                 var top = constraints.biggest.height;
//
//                 return FlexibleSpaceBar(
//                   background: Hero(
//                     tag: widget.restaurants.pictureId,
//                     child: Image.network(
//                       widget.restaurants.pictureId,
//                       fit: BoxFit.fitWidth,
//                     ),
//                   ),
//                   title: Text(
//                     top > 80 && top < 125 ? widget.restaurants.name : "",
//                   ),
//                   titlePadding: EdgeInsets.symmetric(
//                       vertical: 16.0,
//                       horizontal: _horizontalTitlePadding + 16.0),
//                 );
//               }),
//             )
//           ];
//         },
//         body: ListView(
//           padding: const EdgeInsets.all(10.0),
//           children: [
//             Column(
//               children: [
//                 Text(
//                   widget.restaurants.name,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 25.0),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(Icons.maps_home_work_rounded, size: 20.0, color: Colors.grey,),
//                       Text(" ${widget.restaurants.city}"),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
//                   child: const Text(
//                     "Description",
//                     style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 20.0),
//                   child: Text(
//                     widget.restaurants.description,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const Text(
//                   "Menu",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20.0)),
//                         margin: const EdgeInsets.only(
//                             right: 16.0, left: 16.0, top: 20.0),
//                         child: InkWell(
//                           onTap: () {
//                             showAvatarModalBottomSheet(
//                                 title: "food",
//                                 context: context,
//                                 builder: (context) {
//                                   List<String> listContent = [];
//                                   for (var element
//                                       in widget.restaurants.menu.listFood) {
//                                     listContent.add(element.name);
//                                   }
//                                   return ModalContent(
//                                       title: "Food", content: listContent);
//                                 });
//                           },
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(
//                                     8.0, 8.0, 8.0, 0.0),
//                                 child: Image.asset(
//                                   "assets/images/food.png",
//                                   width: 100,
//                                   height: 100,
//                                 ),
//                               ),
//                               const Padding(
//                                 padding:
//                                     EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
//                                 child: Text(
//                                   "Foods",
//                                   style: TextStyle(
//                                       fontSize: 18.0,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20.0)),
//                         margin: const EdgeInsets.only(
//                             right: 16.0, left: 16.0, top: 20.0),
//                         child: InkWell(
//                           onTap: () {
//                             showAvatarModalBottomSheet(
//                                 title: "drink",
//                                 context: context,
//                                 builder: (context) {
//                                   List<String> listContent = [];
//                                   for (var element
//                                       in widget.restaurants.menu.listDrink) {
//                                     listContent.add(element.name);
//                                   }
//                                   return ModalContent(
//                                       title: "Drink", content: listContent);
//                                 });
//                           },
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(
//                                     8.0, 8.0, 8.0, 0.0),
//                                 child: Image.asset(
//                                   "assets/images/drink.png",
//                                   width: 100,
//                                   height: 100,
//                                 ),
//                               ),
//                               const Padding(
//                                 padding:
//                                     EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
//                                 child: Text(
//                                   "Drinks",
//                                   style: TextStyle(
//                                       fontSize: 18.0,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   double get _horizontalTitlePadding {
//     const kBasePadding = 15.0;
//     const kMultiplier = 0.5;
//
//     if (_scrollController.hasClients) {
//       if (_scrollController.offset < (kExpandedHeight / 2)) {
//         return kBasePadding;
//       }
//
//       if (_scrollController.offset > (kExpandedHeight - kToolbarHeight)) {
//         return (kExpandedHeight / 2 - kToolbarHeight) * kMultiplier +
//             kBasePadding;
//       }
//
//       return (_scrollController.offset - (kExpandedHeight / 2)) * kMultiplier +
//           kBasePadding;
//     }
//
//     return kBasePadding;
//   }
// }
