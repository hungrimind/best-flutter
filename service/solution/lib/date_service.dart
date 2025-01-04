import 'package:flutter/foundation.dart';

class DateService {
  final ValueNotifier<DateTime> dateNotifier = ValueNotifier(DateTime.now());

  void updateDate() {
    dateNotifier.value = DateTime.now();
  }

  void dispose() {
    dateNotifier.dispose();
  }
} 