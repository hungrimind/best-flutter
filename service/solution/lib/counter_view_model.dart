import 'package:demo/date_service.dart';
import 'package:flutter/foundation.dart';

class CounterViewModel {
  CounterViewModel({required DateService dateService})
      : _dateService = dateService;
  final DateService _dateService;

  final ValueNotifier<int> countNotifier = ValueNotifier(0);
  ValueNotifier<DateTime> get dateService => _dateService.dateNotifier;

  void increment() {
    countNotifier.value += 2;
  }

  void updateDate() {
    _dateService.updateDate();
  }

  void dispose() {
    countNotifier.dispose();
  }
}
