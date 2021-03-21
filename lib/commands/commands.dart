import 'package:crowdfund_app/models/app_model.dart';
import 'package:crowdfund_app/services/auth_user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

BuildContext? _mainContext;
BuildContext? get mainContext => _mainContext;

void setContext(BuildContext c) {
  _mainContext = c;
}

class BaseAppCommand {
  /// Provide quick lookups for the main models and services in the app
  T getProvided<T>() {
    assert(_mainContext != null,
        "You must call AbstractCommand.init(BuildContext) methd before calling Commands");
    return _mainContext!.read<T>();
  }

  Authentication get authentication => getProvided();
  AppModel get appModel => getProvided();
}
