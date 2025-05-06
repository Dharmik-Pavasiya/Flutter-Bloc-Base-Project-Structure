import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastService {
  static final ToastService instance = ToastService._internal();

  factory ToastService() => instance;

  ToastService._internal();

  static late final GlobalKey<NavigatorState> _navigatorKey;

  /// Initialize with the same navigator key used in MaterialApp
  static void init(GlobalKey<NavigatorState> navigatorKey) {
    _navigatorKey = navigatorKey;
  }

  void showSuccess({String? message, String? title}) {
    _showToast(
      message: message ?? "",
      title: title ?? 'Success',
      type: ToastificationType.success,
    );
  }

  void showError({String? message, String? title}) {
    _showToast(
      message: message ?? "",
      title: title ?? 'Error',
      type: ToastificationType.error,
    );
  }

  void showInfo(String message, {String? title}) {
    _showToast(
      message: message,
      title: title ?? 'Info',
      type: ToastificationType.info,
    );
  }

  void showWarning(String message, {String? title}) {
    _showToast(
      message: message,
      title: title ?? 'Warning',
      type: ToastificationType.warning,
    );
  }

  void _showToast({
    required String message,
    required String title,
    required ToastificationType type,
  }) {
    final context = _navigatorKey.currentContext;
    if (context == null) return;

    toastification.dismissAll();

    // Get the appropriate color for the toast type
    final Color backgroundColor = _getColorForType(type);
    final Color textColor = _getTextColorForType(type);

    toastification.show(
      context: context,
      type: type,
      title: Text(title, style: TextStyle(color: textColor)),
      description:
          message.isNotEmpty
              ? Text(message, style: TextStyle(color: textColor))
              : null,
      alignment: Alignment.topCenter,
      backgroundColor: backgroundColor,
      autoCloseDuration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 300),
      closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
      borderSide: BorderSide(color: Colors.transparent),
      style: ToastificationStyle.flat,
      dragToClose: true,
      closeOnClick: true,
      dismissDirection: DismissDirection.up,
      icon: Icon(_getIconForType(type), color: textColor),
    );
  }

  Color _getColorForType(ToastificationType type) {
    switch (type) {
      case ToastificationType.success:
        return Colors.green.shade700; // Darker green for better contrast
      case ToastificationType.error:
        return Colors.red.shade700; // Darker red for better contrast
      case ToastificationType.info:
        return Colors.blue.shade700; // Darker blue for better contrast
      case ToastificationType.warning:
        return Colors.orange.shade700; // Darker orange for better contrast
      default:
        return Colors.grey.shade800;
    }
  }

  Color _getTextColorForType(ToastificationType type) {
    // For all types, we'll use white text for better contrast
    return Colors.white;
  }

  IconData _getIconForType(ToastificationType type) {
    switch (type) {
      case ToastificationType.success:
        return Icons.check_circle;
      case ToastificationType.error:
        return Icons.error;
      case ToastificationType.info:
        return Icons.info;
      case ToastificationType.warning:
        return Icons.warning;
      default:
        return Icons.notifications;
    }
  }
}
