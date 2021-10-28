import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AvatarBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;
  final Animation<double> animation;

  const AvatarBottomSheet(
      {Key? key,
      required this.title,
      required this.child,
      required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          SafeArea(
            bottom: false,
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) => Transform.translate(
                  offset: Offset(0, (1 - animation.value) * 100),
                  child: Opacity(
                      child: child, opacity: max(0, animation.value * 2 - 1))),
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 20),
                  CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: (title == "food")
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
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 10,
                            color: Colors.black12,
                            spreadRadius: 5)
                      ]),
                  width: double.infinity,
                  child: MediaQuery.removePadding(
                      context: context, removeTop: true, child: child)),
            ),
          ),
        ],
      ),
    );
  }
}

Future<T?> showAvatarModalBottomSheet<T>({
  required String title,
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior,
  Color barrierColor = Colors.black87,
  bool bounce = true,
  bool expand = false,
  AnimationController? secondAnimation,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  Duration? duration,
}) async {
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));
  final result =
      await Navigator.of(context, rootNavigator: useRootNavigator).push(
    ModalBottomSheetRoute<T>(
      builder: builder,
      containerBuilder: (_, animation, child) => AvatarBottomSheet(
        title: title,
        child: child,
        animation: animation,
      ),
      bounce: bounce,
      secondAnimationController: secondAnimation,
      expanded: expand,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      isDismissible: isDismissible,
      modalBarrierColor: barrierColor,
      enableDrag: enableDrag,
      duration: duration,
    ),
  );
  return result;
}
