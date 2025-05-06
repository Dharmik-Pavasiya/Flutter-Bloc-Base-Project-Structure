import 'dart:developer';

import 'package:flutter/material.dart';

extension StringExtension on String {
  String get toCapital =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";

  void get printSuccess => log(this, name: "Log");

  void get printError => log("", name: "Error", error: this as Object);
}

extension IntegetExtension on int? {
  bool get success {
    if (this == 200 || this == 201 || this == 204) {
      return true;
    }
    return false;
  }

  SizedBox get height => SizedBox(height: (this ?? 0).toDouble());

  SizedBox get width => SizedBox(width: (this ?? 0).toDouble());
}

extension DoubleExtension on double? {
  SizedBox get height => SizedBox(height: (this ?? 0).toDouble());

  SizedBox get width => SizedBox(width: (this ?? 0).toDouble());
}

extension GeneralExtension<T> on T {
  bool get isEnum {
    final split = toString().split('.');
    return split.length > 1 && split[0] == runtimeType.toString();
  }

  String get getEnumString {
    return toString().split('.').last.toCapital;
  }
}

extension IterableExtension<T> on Iterable<T> {
  Iterable<E> mapWithIndex<E>(E Function(int index, T value) f) {
    return Iterable.generate(length).map((i) => f(i, elementAt(i)));
  }
}

extension MapExtension on Map {
  String get format {
    if (isEmpty) {
      return "";
    } else {
      var firstKey = entries.first.key;
      var mapValues = entries.first.value;
      return "?$firstKey=$mapValues";
    }
  }
}

extension WidgetExtention on Widget {
  /// Adds padding around the widget
  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    ),
    child: this,
  );

  /// Adds margin around the widget
  Widget marginAll(double value) =>
      Container(margin: EdgeInsets.all(value), child: this);

  Widget marginSymmetric({double horizontal = 0, double vertical = 0}) =>
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  Widget marginOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Container(
    margin: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
    child: this,
  );
}
