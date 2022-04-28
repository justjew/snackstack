import 'package:flutter/material.dart';

import 'snack_action.dart';

abstract class SnackstackEvent {}

class SnackEvent extends SnackstackEvent {
  final Color color;
  final String title;
  final String? description;
  final Duration duration;
  final List<SnackAction> actions;
  final bool unique;
  final SnackEventHapticType? hapticType;
  final int? _timestamp;

  SnackEvent({
    required this.color,
    required this.title,
    this.description,
    this.duration = const Duration(seconds: 5),
    this.actions = const [],
    this.unique = false,
    this.hapticType,
  }) : _timestamp = unique ? DateTime.now().millisecondsSinceEpoch : null;

  @override
  bool operator ==(Object? other) {
    if (other is! SnackEvent) {
      return false;
    }

    return hashCode == other.hashCode;

    // if (unique || other.unique) {
    //   return false;
    // }

    // return color == other.color &&
    //     title == other.title &&
    //     description == other.description &&
    //     _timestamp == _timestamp;
  }

  @override
  int get hashCode => Object.hash(color, title, description, _timestamp);
}

enum SnackEventHapticType { click, light, medium, heavy, vibrate }

class SnackstackClear extends SnackstackEvent {}
