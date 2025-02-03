import 'package:demo/counter_repository.dart';
import 'package:demo/result.dart';
import 'package:flutter/foundation.dart';

class CounterViewModel {
  CounterViewModel(this.counterRepository);
  final CounterRepository counterRepository;

  final ValueNotifier<FakeLessonException?> issuesNotifier =
      ValueNotifier(null);

  void fetchNumberFromFakeApi() {
    final result = counterRepository.fetchNumberFromFakeApi();
    switch (result) {
      case Ok():
        issuesNotifier.value = null;
      case Error():
          issuesNotifier.value = result.error;
    }
  }

  void dispose() {
    issuesNotifier.dispose();
  }
}
