import 'package:demo/counter_repository.dart';
import 'package:flutter/foundation.dart';

class CounterViewModel {
  CounterViewModel(this.counterRepository);
  final CounterRepository counterRepository;

  final ValueNotifier<FakeLessonException?> issuesNotifier = ValueNotifier(null);

  void fetchNumberFromFakeApi() {
    try {
      // we are simulating a scenario where the fetchNumberFromFakeApi method throws an exception
      counterRepository.fetchNumberFromFakeApi();
      issuesNotifier.value = null;
    } catch (e) {
      // we should catch the specific exception here and assign it to issuesNotifier
    }
  }

  void dispose() {
    issuesNotifier.dispose();
  }
}