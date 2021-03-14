import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppRouterDelegate extends RouterDelegate with ChangeNotifier {
  AppRouterDelegate();

  // Returns a navigator, to match the current app state
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  @override
  Future<bool> popRoute() {
    return Future.delayed(Duration(microseconds: 1), () => true);
  }

  @override
  Future<void> setNewRoutePath(configuration) {
    return Future.delayed(Duration(seconds: 1));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
