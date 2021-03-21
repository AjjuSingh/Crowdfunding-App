import 'package:crowdfund_app/models/app_user_model.dart';
import 'package:crowdfund_app/services/auth_user_service_impl.dart';
import 'package:flutter/foundation.dart';

class AuthenticationFactory {
  static bool _initComplete = false;
  static Authentication create() {
    Authentication auth = AuthenticationServiceImpl();
    if (_initComplete == false) {
      auth.init();
    }
    return auth;
  }
}

abstract class Authentication {
  /// /////////////////////////////////////////////////
  /// Concrete Methods
  /// //////////////////////////////////////////////////

  // shared setUserId method
  String? _token;
  String get userId => _token!;
  set token(String? value) => _token = value;

  void init();

  // ////////////////////////////////////////////////////
  /// SignIn and signOut abstract methods
  // /////////////////////////////////////////////////////

  Future<AppUser> signIn(
      {String? email, String? password, bool createAccount = false});
  bool? get isSignedIn;
  set setIsSignedIn(bool? val) {}

  @mustCallSuper
  Future<void> signOut() async {
    setIsSignedIn = false;
    token = null;
  }
}
