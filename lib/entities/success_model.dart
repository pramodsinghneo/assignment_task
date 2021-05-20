class SuccessModel {
  final String message;

  SuccessModel({required this.message});

  factory SuccessModel.fromJson(Map<String, dynamic> json) => SuccessModel(
        message: json["message"] != null ? json["message"] : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
