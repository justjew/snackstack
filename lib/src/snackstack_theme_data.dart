import 'package:flutter/material.dart';

class SnackstackThemeData {
  final SnackTileThemeData tileTheme;
  final Duration appearDuration;
  final Duration resizeDuration;
  final Curve resizeTimeCurve;
  final Curve appearCurve;

  const SnackstackThemeData({
    this.tileTheme = const SnackTileThemeData(),
    this.appearDuration = const Duration(milliseconds: 250),
    this.resizeDuration = const Duration(milliseconds: 200),
    this.resizeTimeCurve = const Interval(0.4, 1.0, curve: Curves.ease),
    this.appearCurve = Curves.easeInOutBack,
  });
}

class SnackTileThemeData {
  final BoxDecoration decoration;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double? width;

  const SnackTileThemeData({
    this.decoration = const BoxDecoration(),
    this.margin = const EdgeInsets.symmetric(horizontal: 20),
    this.padding = const EdgeInsets.all(10),
    this.width,
  });
}
