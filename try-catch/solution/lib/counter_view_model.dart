import 'package:demo/counter_repository.dart';
import 'package:flutter/foundation.dart';

class CounterViewModel {
  CounterViewModel(this.counterRepository);
  final CounterRepository counterRepository;

  final ValueNotifier<FakeLessonException?> issuesNotifier =
      ValueNotifier(null);

  void fetchNumberFromFakeApi() {
    try {
      // we are simulating a scenario where the fetchNumberFromFakeApi method throws an exception
      counterRepository.fetchNumberFromFakeApi();
      issuesNotifier.value = null;
    } on FakeLessonException catch (e) {
      issuesNotifier.value = e;
    }
  }

  void dispose() {
    issuesNotifier.dispose();
  }
}
