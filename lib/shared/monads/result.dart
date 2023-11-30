class Result<T> {
  final bool success;
  final T? value;
  final String? error;

  Result({required this.success, required this.value, required this.error});

  factory Result.fromSuccess(T value) => 
    Result(success: true, value: value, error: null);

  factory Result.fromFailure(String error) =>
    Result(success: false, value: null, error: error);
}