class FakeLessonException implements Exception {
  FakeLessonException(this.message);

  final String message;

  @override
  String toString() => 'FakeLessonException: message';
}

class CounterRepository {
  int fetchNumberFromFakeApi() {
    throw FakeLessonException('Thanks for catching me!');
  }
}