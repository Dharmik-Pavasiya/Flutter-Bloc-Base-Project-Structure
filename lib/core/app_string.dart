class AppString {
  AppString._();

  //Network error
  static const noInternetConnection = "No internet connection";

  //Api call error
  static const cancelRequest = "Request to API server was cancelled";
  static const connectionTimeOut = "Connection timeout with API server";
  static const receiveTimeOut = "Receive timeout in connection with API server";
  static const requestTimeOut =
      "Request timeout in connection with the API server";
  static const connectionError =
      "Connection error in connection with the API server";
  static const badCertificate =
      "Bad certificate in connection with the API server";
  static const notFoundResource = "Resource was not found";
  static const sendTimeOut = "Send timeout in connection with API server";
  static const socketException = "Check your internet connection";
  static const unexpectedError = "Unexpected error occurred";
  static const unknownError = "Something went";
  static const duplicateEmail = "Email has already been taken";
  static const serviceUnavailable =
      "The server is currently unable to handle requests.";

  //status code
  static const badRequest = "Bad request";
  static const unauthorized = "Unauthorized";
  static const forbidden = "Forbidden";
  static const notFound = "Not found";
  static const internalServerError = "Internal server error";
  static const badGateway = "Bad gateway";
}
