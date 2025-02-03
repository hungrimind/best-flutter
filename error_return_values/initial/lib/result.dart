sealed class Result<T, R> {
  const Result();

  /// Creates an instance of Result containing a value
  factory Result.ok(T value) => Ok(value);

  /// Create an instance of Result containing an error
  factory Result.error(R result) => Error(result);
}

/// Subclass of Result for values
final class Ok<T, R> extends Result<T, R> {
  const Ok(this.value);

  /// Returned value in result
  final T value;
}

/// Subclass of Result for errors
final class Error<T, R> extends Result<T, R> {
  const Error(this.error);

  /// Returned result in result
  final R error;
}