import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Custom navigator class for widget to widget
class AppNavigator {
  static push(BuildContext context, Widget child) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => child));
  }

  static pushReplacement(BuildContext context, Widget child) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => child));
  }

  static pustNamedAndReplaceUntil(BuildContext context, String route) {
    Navigator.pushNamedAndRemoveUntil(context, "/$route", (route) => false);
  }

  static pushReplacementtAndRemoveUntil(BuildContext context, Widget child) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => child), (route) => false);
  }
}
