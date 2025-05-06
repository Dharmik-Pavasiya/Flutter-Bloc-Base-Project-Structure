import 'package:equatable/equatable.dart';

/*
{
	"status": true,
	"statusCode": 200,
	"message": "Login Successfully",
	"data": {
		"id": 2,
		"email": "dharmik.p@yopmail.com",
		"userName": "Dharmik8080"
	}
}*/

class ApiResponse extends Equatable {
  const ApiResponse({this.status, this.statusCode, this.message, this.data});

  final bool? status;
  final num? statusCode;
  final String? message;
  final dynamic data;

  ApiResponse copyWith({
    bool? status,
    num? statusCode,
    String? message,
    dynamic data,
  }) {
    return ApiResponse(
      status: status ?? this.status,
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json["status"],
      statusCode: json["statusCode"],
      message: json["message"],
      data: json["data"],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "data": data,
  };

  @override
  String toString() {
    return "$status, $statusCode, $message, $data, ";
  }

  @override
  List<Object?> get props => [status, statusCode, message, data];
}
