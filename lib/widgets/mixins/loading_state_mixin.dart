import 'package:flutter/material.dart';

mixin LoadingStateMixin<T extends StatefulWidget> on State<T> {
  bool _isLoading = false;

  bool get isLoading => isLoading;

  set isLoading(bool isLoading) {
    if (!mounted) return;
    setState(() {
      _isLoading = isLoading;
    });
  }

  Future<R> load<R>(Future<R> action()) async {
    isLoading = true;
    R result = await action.call();
    isLoading = false;
    return result;
  }
}
