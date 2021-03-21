import 'package:flutter/cupertino.dart';

class EasyNotifier extends ChangeNotifier {
  void notify([VoidCallback? action]) {
    action!.call();
    notifyListeners();
  }
}
