class ErrorModel {
  final int status;
  final int error;
  final String message;

  ErrorModel(
      {required this.status, required this.error, required this.message});

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        status: json["status"] != null ? json["status"] : null,
        error: json["error"] != null ? json["error"] : null,
        message: json["message"] != null ? json["message"] : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "message": message,
      };
}
