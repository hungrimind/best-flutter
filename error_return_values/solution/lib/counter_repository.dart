import 'package:demo/result.dart';

class FakeLessonException implements Exception {
  FakeLessonException(this.message);

  final String message;

  @override
  String toString() => 'FakeLessonException: message';
}

class CounterRepository {
  Result<int, FakeLessonException> fetchNumberFromFakeApi() {
    return Result.error(FakeLessonException('Thanks for catching me!'));
  }
}