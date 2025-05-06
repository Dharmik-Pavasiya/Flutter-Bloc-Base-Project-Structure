class ApiConfig {
  ApiConfig._();

  static const token =
      "6369de3d8da8e764cc3c1cbe4121bb6741875de2c30dfd39df8fd351b6a508ea";
  static const String baseUrl = "http://10.0.2.2:3001/v1/api";
  static const Duration receiveTimeout = Duration(milliseconds: 15000);
  static const Duration connectionTimeout = Duration(milliseconds: 15000);
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String forgotPassword = '/auth/forgot-password';
}
