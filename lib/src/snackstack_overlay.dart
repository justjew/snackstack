import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snackstack/src/snack_position.dart';

import 'snack_events.dart';
import 'snack_event_tile.dart';
import 'snackstack_manager.dart';
import 'snackstack_theme_data.dart';

/// A widget that is listening to [SnackstackManager]'s stream and
/// draws snack items over the screen.
class SnackstackOverlay extends StatefulWidget {
  final SnackstackThemeData themeData;
  final SnackPosition position;

  const SnackstackOverlay({
    Key? key,
    required this.themeData,
    required this.position,
  }) : super(key: key);

  @override
  _SnackstackOverlayState createState() => _SnackstackOverlayState();
}

class _SnackstackOverlayState extends State<SnackstackOverlay> {
  final SnackstackManager manager = SnackstackManager();
  late final StreamSubscription _subscription;

  List<SnackEvent> events = [];

  @override
  void initState() {
    super.initState();
    _subscription = manager.subscribe(_handleEvents);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      verticalDirection: widget.position == SnackPosition.bottom
          ? VerticalDirection.up
          : VerticalDirection.down,
      children: _buildEvents(),
    );
  }

  List<Widget> _buildEvents() {
    return events.map((e) {
      return SnackEventTile(
        key: ValueKey(e),
        position: widget.position,
        themeData: widget.themeData,
        event: e,
        onDismiss: () => _dismiss(e),
        timerDuration: e.duration,
        onTap: e.onTap,
      );
    }).toList();
  }

  void _handleEvents(SnackstackEvent event) {
    if (event is SnackEvent) {
      _doHaptic(event);

      if (events.contains(event)) {
        return;
      }

      return setState(() {
        events.add(event);
      });
    }

    if (event is SnackstackClear) {
      return setState(() {
        events.clear();
      });
    }
  }

  void _doHaptic(SnackEvent event) {
    switch (event.hapticType) {
      case SnackEventHapticType.click:
        HapticFeedback.selectionClick();
        break;
      case SnackEventHapticType.light:
        HapticFeedback.lightImpact();
        break;
      case SnackEventHapticType.medium:
        HapticFeedback.mediumImpact();
        break;
      case SnackEventHapticType.heavy:
        HapticFeedback.heavyImpact();
        break;
      case SnackEventHapticType.vibrate:
        HapticFeedback.vibrate();
        break;
      default:
        return;
    }
  }

  void _dismiss(SnackEvent event) {
    setState(() {
      events.remove(event);
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
