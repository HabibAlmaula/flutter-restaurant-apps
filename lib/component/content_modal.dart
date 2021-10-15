import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      appBar: CupertinoNavigationBar(leading: Container(), middle: Text(title)),
      body: SafeArea(
          bottom: false,
          child: ListView.separated(
            itemCount: content!.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {},
                  child: _buildItemMenu(context, content![index]));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              height: 1.0,
            ),
          )),
    ));
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
          // child: Icon(Icons.restaurant_menu_rounded),
          radius: 32,
        ),
        title: Text(name),
      ),
    );
  }
}
