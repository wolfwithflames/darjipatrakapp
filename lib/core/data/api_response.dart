import 'json_serializable.dart';

class ApiResponse<T> {
  bool success;
  String message;
  T data;
  ApiResponse({
    required this.success,
    this.message = "",
    required this.data,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, Function(dynamic) create) {
    return ApiResponse<T>(
      success: JsonSerializableUtils.boolParse(json["status"]),
      message: json["message"],
      data: create(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": this.success,
        "message": this.message,
        "data": this.data,
      };
}

abstract class Serializable {
  Map<String, dynamic> toJson();
}
