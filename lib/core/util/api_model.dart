enum Status { SUCCESS, FAILURE }

class AppResult<T> {
  AppResult();
  Status? status;
  String? message;
  int? statusCode;
  T? data;

  AppResult.success([this.data]) : status = Status.SUCCESS;

  AppResult.failure([this.message, this.statusCode]) : status = Status.FAILURE;
}
