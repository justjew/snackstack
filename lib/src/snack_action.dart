import 'package:flutter/material.dart';

class SnackAction {
  final Function() onPressed;
  final Widget child;

  SnackAction({
    required this.onPressed,
    required this.child,
  });
}
