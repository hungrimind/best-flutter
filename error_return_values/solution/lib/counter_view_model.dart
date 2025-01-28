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
      case Ok<int>():
        issuesNotifier.value = null;
      case Error():
        if (result.error is FakeLessonException) {
          issuesNotifier.value = result.error as FakeLessonException;
        }
    }
  }

  void dispose() {
    issuesNotifier.dispose();
  }
}
