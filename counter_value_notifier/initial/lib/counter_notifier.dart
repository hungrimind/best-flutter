import 'package:flutter/foundation.dart';

class CounterNotifier {
  final ValueNotifier<int> countNotifier = ValueNotifier(0);

  void increment() {
    countNotifier.value += 1;
  }

  void dispose() {
    countNotifier.dispose();
  }
}