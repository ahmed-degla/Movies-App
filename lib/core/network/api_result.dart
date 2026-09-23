typedef FutureApiResult<T> = Future<ApiResult<T>>;

sealed class ApiResult<T> {
  const ApiResult();
}

class ApiSuccess<T> extends ApiResult<T> {
  const ApiSuccess({required this.data});

  final T data;
}

class ApiError<T> extends ApiResult<T> {
  const ApiError({required this.message});

  final String message;
}
