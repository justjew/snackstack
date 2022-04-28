import 'package:flutter/material.dart';

import 'snack_position.dart';
import 'snackstack_overlay.dart';
import 'snackstack_theme_data.dart';


/// A widget that puts snackstack over [child].
class SnackstackWrapper extends StatelessWidget {
  final Widget child;
  final SnackPosition position;
  final double yOffset;
  final ThemeData appThemeData;
  final SnackstackThemeData snackstackThemeData;

  const SnackstackWrapper({
    Key? key,
    required this.appThemeData,
    required this.child,
    this.position = SnackPosition.bottom,
    this.yOffset = 40,
    this.snackstackThemeData = const SnackstackThemeData(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appThemeData,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: child,
          ),
          Positioned(
            top: position == SnackPosition.top ? yOffset : null,
            bottom: position == SnackPosition.bottom ? yOffset : null,
            child: SnackstackOverlay(
              themeData: snackstackThemeData,
              position: position,
            ),
          ),
        ],
      ),
    );
  }
}
