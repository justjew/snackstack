import 'package:flutter/material.dart';
import 'package:snackstack/src/snackstack_theme_data.dart';

import 'snack_events.dart';

class SnackEventTileContent extends StatelessWidget {
  final SnackstackThemeData themeData;
  final SnackEvent event;
  final Function() onClose;

  SnackTileThemeData get tileTheme => themeData.tileTheme;

  const SnackEventTileContent({
    Key? key,
    required this.themeData,
    required this.event,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    late final double width;
    if (tileTheme.width == null) {
      final double screenWidth = MediaQuery.of(context).size.width;
      width = screenWidth - tileTheme.margin.horizontal;
    } else {
      width = tileTheme.width ?? 250;
    }

    return Container(
      padding: tileTheme.padding,
      width: width,
      decoration: tileTheme.decoration.copyWith(color: event.color),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (event.description != null)
                  const SizedBox(
                    height: 6,
                  ),
                if (event.description != null)
                  Text(
                    event.description ?? '',
                    overflow: TextOverflow.clip,
                    style: textTheme.bodyMedium!.copyWith(color: Colors.white),
                  ),
              ],
            ),
          ),
          if (event.actions.isNotEmpty)
            const SizedBox(
              width: 10,
            ),
          for (final action in event.actions)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                action.onPressed();
                onClose();
              },
              child: action.child,
            ),
        ],
      ),
    );
  }
}
