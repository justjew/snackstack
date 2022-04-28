import 'dart:async';

import 'snack_events.dart';

/// A singleton class that is used to manage snack stack.
/// Call [add] to put a new [SnackbarEvent].
/// Use [clear] to clean the stack up.
class SnackstackManager {
  final StreamController<SnackstackEvent> eventPool = StreamController<SnackstackEvent>.broadcast();

  static final SnackstackManager _singleton = SnackstackManager._internal();

  factory SnackstackManager() {
    return _singleton;
  }

  SnackstackManager._internal();

  StreamSubscription<SnackstackEvent> subscribe(Function(SnackstackEvent event) fn) {
    return eventPool.stream.listen(fn);
  }

  void add(SnackEvent event) {
    eventPool.add(event);
  }

  void clear() {
    eventPool.add(SnackstackClear());
  }
}
