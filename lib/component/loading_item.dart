import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

   const ShimmerWidget.rectangular(
      {Key? key, this.width = double.infinity, required this.height})
      : shapeBorder = const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))), super(key: key);

   const ShimmerWidget.circular(
      {Key? key, this.width = double.infinity,
      required this.height,
      this.shapeBorder = const CircleBorder()}) : super(key: key);

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

class ErrorOrNoData extends StatelessWidget {
  final String type;
  final VoidCallback? buttonTap;

  const ErrorOrNoData({Key? key, required this.type, this.buttonTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child: SvgPicture.asset(
              (type == "nodata")
                  ? "assets/images/cooking_food.svg"
                  : "assets/images/error.svg",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0,),
            child: Text((type == "nodata") ? "Data tidak ditemukan!" : "Koneksi Error!", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
          ),
          Visibility(
              visible: (type == "nodata") ? false : true,
              child: ElevatedButton(
                  onPressed: buttonTap, child: const Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                    child: Text("reload"),
                  )))
        ],
      ),
    );
  }
}
