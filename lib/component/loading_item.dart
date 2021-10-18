import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular(
      {this.width = double.infinity, required this.height})
      : shapeBorder = const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)));

  const ShimmerWidget.circular(
      {this.width = double.infinity,
      required this.height,
      this.shapeBorder = const CircleBorder()});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey[300]!,
        period: const Duration(seconds: 2),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey[400]!,
            shape: shapeBorder,
          ),
        ),
      );
}

Widget errorOrNoData(String type) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          (type == "nodata")
              ? "assets/images/cooking_food.svg"
              : "assets/images/error.svg",
          color: Colors.deepOrange,
        ),
        Text((type == "nodata") ? "Data tidak ditemukan!" : "Koneksi Error!"),
      ],
    ),
  );
}
