import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_app/component/custom_dialog.dart';

class ModalContent extends StatelessWidget {
  final List<String>? content;
  final String title;
  final bool reverse;

  const ModalContent(
      {Key? key, this.content, this.title = "Modal Page", this.reverse = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar:
            CupertinoNavigationBar(leading: Container(), middle: Text(title)),
        body: SafeArea(
          bottom: false,
          child: ListView.separated(
            itemCount: content!.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return CustomDialogBox(
                            title: "Order $title?",
                            descriptions: RichText(
                              text: TextSpan(
                                text: "Anda ingin order ",
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: content![index],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const TextSpan(text: ' ?!'),
                                ],
                              ),
                            ),
                            text: "Ya",
                            img: (title == 'Food')
                                ? "assets/images/food.png"
                                : "assets/images/drink.png");
                      },
                    ).then(
                      (value) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) {
                              Future.delayed(const Duration(seconds: 8), () {
                                Navigator.of(context).pop(true);
                              });

                              return AlertDialog(
                                content: FutureBuilder(
                                    future: Future.delayed(
                                        const Duration(seconds: 5)),
                                    builder: (c, s) {
                                      if (s.connectionState ==
                                          ConnectionState.done) {
                                        return buildLoadingOrder(
                                            context,
                                            "assets/json/success_lottie.json",
                                            "Berhasil memproses order");
                                      } else {
                                        return buildLoadingOrder(
                                            context,
                                            "assets/json/food_delivery_lottie.json",
                                            "Sedang memproses pesanan");
                                      }
                                    }),
                              );
                            },
                            barrierDismissible: false);
                      },
                    );
                  },
                  child: _buildItemMenu(context, content![index]));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemMenu(BuildContext context, String name) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.amber,
          child: (title == "Food")
              ? Image.asset(
                  "assets/images/food.png",
                  scale: 2,
                )
              : Image.asset(
                  "assets/images/drink.png",
                  scale: 2,
                ),
          radius: 32,
        ),
        title: Text(name),
      ),
    );
  }

  Widget buildLoadingOrder(BuildContext context, String asset, String message) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(asset,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width - 200.0),
        Text(
          message,
          style: GoogleFonts.ptSansNarrow(
            textStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
        )
      ],
    );
  }
}
