import 'package:crowdfund_app/main.dart';
import 'package:crowdfund_app/models/app_model.dart';
import 'package:crowdfund_app/services/auth_user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppRouterDelegate extends RouterDelegate with ChangeNotifier {
  final AppModel appModel;
  final Authentication authentication;
  AppRouterDelegate(this.appModel, this.authentication) {
    appModel.addListener(notifyListeners);
  }

  // Returns a navigator, to match the current app state
  @override
  Widget build(BuildContext context) {
    return SizedBox();
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
    appModel.removeListener(notifyListeners);
    super.dispose();
  }
}
