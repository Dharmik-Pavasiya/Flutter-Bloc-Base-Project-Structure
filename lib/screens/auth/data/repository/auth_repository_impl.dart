import 'package:dio/dio.dart';
import 'package:flutter_bloc_base_structure/common/model/api_response_model.dart';
import 'package:flutter_bloc_base_structure/common/network/api_service.dart';
import 'package:flutter_bloc_base_structure/core/api_config.dart';

import '../../../../common/utils/either/either.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl extends ApiService implements AuthRepository {
  @override
  Future<Either<String, ApiResponse>> login({
    required String usernameOrEmail,
    required String password,
  }) async {
    try {
      final model = await postRequest(
        endpoint: ApiConfig.login,
        data: {"userName": usernameOrEmail, "password": password},
      );
      return Either.right(value: ApiResponse.fromJson(model.data));
    } on DioException catch (e) {
      return Either.left(value: e.message ?? "");
    }
  }

  @override
  Future<Either<String, ApiResponse>> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final model = await postRequest(
        endpoint: ApiConfig.register,
        data: {
          "userName": username,
          "email": email,
          "password": password,
          "confirm_password": confirmPassword,
        },
      );
      return Either.right(value: ApiResponse.fromJson(model.data));
    } on DioException catch (e) {
      return Either.left(value: e.message ?? "");
    }
  }

  @override
  Future<Either<String, ApiResponse>> forgotPassword({
    required String email,
  }) async {
    try {
      final model = await postRequest(
        endpoint: ApiConfig.forgotPassword,
        data: {'email': email},
      );
      return Either.right(value: ApiResponse.fromJson(model.data));
    } on DioException catch (e) {
      return Either.left(value: e.message ?? "");
    }
  }
}
