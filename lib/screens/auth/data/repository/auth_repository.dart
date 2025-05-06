import '../../../../common/model/api_response_model.dart';
import '../../../../common/utils/either/either.dart';

abstract class AuthRepository {
  Future<Either<String, ApiResponse>> login({
    required String usernameOrEmail,
    required String password,
  });

  Future<Either<String, ApiResponse>> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<Either<String, ApiResponse>> forgotPassword({required String email});
}
