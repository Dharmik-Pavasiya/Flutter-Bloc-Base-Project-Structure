import 'package:intl/intl.dart';

/// An interface defining various date and time utility methods.
abstract class IDateTimeService {
  /// Returns the current local date and time.
  DateTime now();

  /// Returns the current UTC date and time.
  DateTime nowUtc();

  /// Formats a [DateTime] object into a string based on the given [pattern].
  /// Defaults to 'yyyy-MM-dd HH:mm:ss' if no pattern is provided.
  String format(DateTime dateTime, {String pattern});

  /// Parses a date string into a [DateTime] object based on the given [pattern].
  /// Defaults to 'yyyy-MM-dd HH:mm:ss' if no pattern is provided.
  DateTime parse(String dateString, {String pattern});

  /// Calculates the difference between two [DateTime] objects.
  Duration difference(DateTime from, DateTime to);

  /// Adds a specified number of days to a [DateTime] object.
  DateTime addDays(DateTime dateTime, int days);

  /// Subtracts a specified number of days from a [DateTime] object.
  DateTime subtractDays(DateTime dateTime, int days);

  /// Adds a [Duration] to a [DateTime] object.
  DateTime addDuration(DateTime dateTime, Duration duration);

  /// Subtracts a [Duration] from a [DateTime] object.
  DateTime subtractDuration(DateTime dateTime, Duration duration);

  /// Checks if a [DateTime] object represents today's date.
  bool isToday(DateTime dateTime);

  /// Checks if a [DateTime] object represents yesterday's date.
  bool isYesterday(DateTime dateTime);

  /// Checks if a [DateTime] object represents tomorrow's date.
  bool isTomorrow(DateTime dateTime);

  /// Checks if two [DateTime] objects represent the same calendar day.
  bool isSameDay(DateTime date1, DateTime date2);

  /// Checks if one [DateTime] object is before another.
  bool isBefore(DateTime a, DateTime b);

  /// Checks if one [DateTime] object is after another.
  bool isAfter(DateTime a, DateTime b);

  /// Converts a [DateTime] object to its epoch time in milliseconds.
  int toEpoch(DateTime dateTime);

  /// Creates a [DateTime] object from an epoch time in milliseconds.
  /// If [isUtc] is true, the resulting [DateTime] will be in UTC.
  DateTime fromEpoch(int millisecondsSinceEpoch, {bool isUtc});

  /// Returns the start of the day for a given [DateTime] object.
  DateTime startOfDay(DateTime dateTime);

  /// Returns the end of the day for a given [DateTime] object.
  DateTime endOfDay(DateTime dateTime);

  /// Returns the start of the week for a given [DateTime] object.
  DateTime startOfWeek(DateTime dateTime);

  /// Returns the end of the week for a given [DateTime] object.
  DateTime endOfWeek(DateTime dateTime);

  /// Returns the start of the month for a given [DateTime] object.
  DateTime startOfMonth(DateTime dateTime);

  /// Returns the end of the month for a given [DateTime] object.
  DateTime endOfMonth(DateTime dateTime);

  /// Calculates the week number for a given [DateTime] object.
  int weekNumber(DateTime dateTime);

  /// Returns the weekday for a given [DateTime] object (1 = Monday, 7 = Sunday).
  int weekday(DateTime dateTime);

  /// Finds the next occurrence of a specific [weekday] from a given [fromDate].
  DateTime nextWeekday(DateTime fromDate, int weekday);

  /// Finds the previous occurrence of a specific [weekday] from a given [fromDate].
  DateTime previousWeekday(DateTime fromDate, int weekday);

  /// Returns a human-readable string representing the time elapsed since a given [DateTime].
  String timeAgo(DateTime dateTime);
}

/// A concrete implementation of [IDateTimeService] providing date and time utilities.
class DateTimeService {
  static DateTime now() => DateTime.now();

  static DateTime nowUtc() => DateTime.now().toUtc();

  static String format(
    DateTime dateTime, {
    String pattern = 'yyyy-MM-dd HH:mm:ss',
  }) => DateFormat(pattern).format(dateTime);

  static DateTime parse(
    String dateString, {
    String pattern = 'yyyy-MM-dd HH:mm:ss',
  }) => DateFormat(pattern).parse(dateString);

  static Duration difference(DateTime from, DateTime to) => to.difference(from);

  static DateTime addDays(DateTime dateTime, int days) =>
      dateTime.add(Duration(days: days));

  static DateTime subtractDays(DateTime dateTime, int days) =>
      dateTime.subtract(Duration(days: days));

  static DateTime addDuration(DateTime dateTime, Duration duration) =>
      dateTime.add(duration);

  static DateTime subtractDuration(DateTime dateTime, Duration duration) =>
      dateTime.subtract(duration);

  static bool isToday(DateTime dateTime) {
    final now = DateTime.now();
    return isSameDay(now, dateTime);
  }

  static bool isYesterday(DateTime dateTime) =>
      isSameDay(now().subtract(Duration(days: 1)), dateTime);

  static bool isTomorrow(DateTime dateTime) =>
      isSameDay(now().add(Duration(days: 1)), dateTime);

  static bool isSameDay(DateTime date1, DateTime date2) =>
      date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;

  static bool isBefore(DateTime a, DateTime b) => a.isBefore(b);

  static bool isAfter(DateTime a, DateTime b) => a.isAfter(b);

  static int toEpoch(DateTime dateTime) => dateTime.millisecondsSinceEpoch;

  static DateTime fromEpoch(int millisecondsSinceEpoch, {bool isUtc = false}) =>
      isUtc
          ? DateTime.fromMillisecondsSinceEpoch(
            millisecondsSinceEpoch,
            isUtc: true,
          )
          : DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);

  static DateTime startOfDay(DateTime dateTime) =>
      DateTime(dateTime.year, dateTime.month, dateTime.day);

  static DateTime endOfDay(DateTime dateTime) =>
      DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59, 999);

  static DateTime startOfWeek(DateTime dateTime) =>
      dateTime.subtract(Duration(days: dateTime.weekday - 1));

  static DateTime endOfWeek(DateTime dateTime) =>
      dateTime.add(Duration(days: 7 - dateTime.weekday));

  static DateTime startOfMonth(DateTime dateTime) =>
      DateTime(dateTime.year, dateTime.month, 1);

  static DateTime endOfMonth(DateTime dateTime) {
    final beginningNextMonth =
        (dateTime.month < 12)
            ? DateTime(dateTime.year, dateTime.month + 1, 1)
            : DateTime(dateTime.year + 1, 1, 1);
    return beginningNextMonth.subtract(Duration(milliseconds: 1));
  }

  static int weekNumber(DateTime dateTime) {
    final firstDayOfYear = DateTime(dateTime.year, 1, 1);
    final diff = dateTime.difference(firstDayOfYear);
    return ((diff.inDays + firstDayOfYear.weekday) / 7).ceil();
  }

  static int weekday(DateTime dateTime) => dateTime.weekday;

  static DateTime nextWeekday(DateTime fromDate, int weekday) {
    var date = fromDate;
    while (date.weekday != weekday) {
      date = date.add(const Duration(days: 1));
    }
    return date;
  }

  static DateTime previousWeekday(DateTime fromDate, int weekday) {
    var date = fromDate;
    while (date.weekday != weekday) {
      date = date.subtract(const Duration(days: 1));
    }
    return date;
  }

  static String timeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);

    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} ${_pluralize("minute", diff.inMinutes)} ago';
    }
    if (diff.inHours < 24) {
      return '${diff.inHours} ${_pluralize("hour", diff.inHours)} ago';
    }
    if (diff.inDays < 7) {
      return '${diff.inDays} ${_pluralize("day", diff.inDays)} ago';
    }
    if (diff.inDays < 30) {
      final weeks = (diff.inDays / 7).floor();
      return '$weeks ${_pluralize("week", weeks)} ago';
    }
    if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return '$months ${_pluralize("month", months)} ago';
    }

    final years = (diff.inDays / 365).floor();
    return '$years ${_pluralize("year", years)} ago';
  }

  static String _pluralize(String word, int count) {
    return count == 1 ? word : '${word}s';
  }
}
