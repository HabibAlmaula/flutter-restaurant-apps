import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:restaurant_app/pages/favourite_page.dart';
import 'package:restaurant_app/pages/setting_page.dart';

Widget actionButtonHome(BuildContext context) {
  return FocusedMenuHolder(
    menuWidth: MediaQuery.of(context).size.width * 0.50,
    blurSize: 5.0,
    menuItemExtent: 45,
    menuBoxDecoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(15.0))),
    duration: const Duration(milliseconds: 100),
    animateMenuItems: true,
    blurBackgroundColor: Colors.black54,
    openWithTap: true,
    menuOffset: 10.0, // Offset value to show menuItem from the selected item
    bottomOffsetHeight:
        80.0, // Offset height to consider, for showing the menu item ( for example bottom navigation bar), so that the popup menu will be shown on top of selected item.
    menuItems: <FocusedMenuItem>[
      FocusedMenuItem(
          title: const Text("Favorite"),
          trailingIcon: const Icon(Icons.favorite_border),
          onPressed: () => Navigator.pushNamed(context, FavouritePage.routeName)),
      FocusedMenuItem(
          title: const Text("Settings"),
          trailingIcon: const Icon(CupertinoIcons.settings),
          onPressed: () => Navigator.pushNamed(context, SettingPage.routeName)),
    ],
    onPressed: () {},
    child: LayoutBuilder(
      builder: (context, constraint) {
        return  Icon(
          CupertinoIcons.ellipsis_circle_fill,
          color: CupertinoColors.white,
          size: constraint.biggest.height,
        );
      },
    ),
  );
}
