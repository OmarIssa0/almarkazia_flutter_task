import 'package:news_app/core/error/failure.dart';

sealed class Result<T> {
  const Result();

  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) failure,
  }) {
    return switch (this) {
      Success<T>(:final data) => success(data),
      FailureResult<T>(failure: final currentFailure) => failure(
        currentFailure,
      ),
    };
  }

  Result<R> map<R>(R Function(T data) transform) {
    return when<Result<R>>(
      success: (data) => Success<R>(transform(data)),
      failure: FailureResult<R>.new,
    );
  }

  bool get isSuccess => this is Success<T>;

  bool get isFailure => this is FailureResult<T>;
}

final class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;
}

final class FailureResult<T> extends Result<T> {
  const FailureResult(this.failure);

  final Failure failure;
}
