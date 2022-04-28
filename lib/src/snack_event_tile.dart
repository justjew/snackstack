import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snackstack/src/snack_position.dart';
import 'package:snackstack/src/snackstack_theme_data.dart';

import 'snack_events.dart';
import 'snack_event_tile_content.dart';

class SnackEventTile extends StatefulWidget {
  final SnackstackThemeData themeData;
  final SnackPosition position;
  final SnackEvent event;
  final Function() onDismiss;
  final Duration timerDuration;

  const SnackEventTile({
    Key? key,
    required this.themeData,
    required this.position,
    required this.event,
    required this.onDismiss,
    this.timerDuration = const Duration(seconds: 5),
  }) : super(key: key);

  @override
  _SnackEventTileState createState() => _SnackEventTileState();
}

class _SnackEventTileState extends State<SnackEventTile>
    with TickerProviderStateMixin {
  late final Duration appearDuration;
  late final Duration resizeDuration;
  late final Curve resizeTimeCurve;
  late final Curve appearCurve;

  late final AnimationController appearController;
  late final Animation<Offset> appearOffsetAnimation;

  late final AnimationController resizeController;
  late final Animation<double> resizeAnimation;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    appearDuration = widget.themeData.appearDuration;
    resizeDuration = widget.themeData.resizeDuration;
    resizeTimeCurve = widget.themeData.resizeTimeCurve;
    appearCurve = widget.themeData.appearCurve;

    appearController = AnimationController(
      vsync: this,
      duration: appearDuration,
    );

    final Offset beginAppearOffset = widget.position == SnackPosition.bottom
        ? const Offset(0, 2)
        : const Offset(0, -2);

    appearOffsetAnimation = Tween<Offset>(
      begin: beginAppearOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: appearController,
      curve: appearCurve,
    ));

    resizeController = AnimationController(
      vsync: this,
      duration: resizeDuration,
    );
    resizeAnimation = resizeController
        .drive(CurveTween(curve: resizeTimeCurve))
        .drive(Tween<double>(begin: 1.0, end: 0.0));

    appearController.forward();

    if (widget.timerDuration != Duration.zero) {
      timer = Timer(widget.timerDuration, close);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) => widget.onDismiss(),
      key: ValueKey(widget.event),
      resizeDuration: resizeDuration,
      child: SizeTransition(
        sizeFactor: resizeAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: FadeTransition(
            opacity: appearController,
            child: SlideTransition(
              position: appearOffsetAnimation,
              child: SnackEventTileContent(
                themeData: widget.themeData,
                event: widget.event,
                onClose: close,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> close() async {
    await appearController.reverse();
    await resizeController.forward();
    widget.onDismiss();
  }

  @override
  void dispose() {
    timer?.cancel();
    appearController.dispose();
    resizeController.dispose();
    super.dispose();
  }
}
