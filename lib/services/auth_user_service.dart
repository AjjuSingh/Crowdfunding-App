import 'package:crowdfund_app/_utils/exceptions/bad_request_exception.dart';
import 'package:crowdfund_app/_utils/safe_print.dart';
import 'package:crowdfund_app/models/app_user_model.dart';
import 'package:crowdfund_app/models/response/post_response_model.dart';
import 'package:crowdfund_app/services/auth_user_service_impl.dart';
import 'package:crowdfund_app/services/http_service.dart';
import 'package:dartz/dartz.dart';
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
  /// Shared setUserId method
  String? _token;
  String get userId => _token!;
  set token(String? value) => _token = value;

  void init();

  /// SignIn and signOut abstract methods
  Future<Either<PostResponse, AppUser>> signIn(
      {String? email, String? password, bool createAccount = false});
  bool? get isSignedIn;
  set setIsSignedIn(bool? val) {}

  Future<PostResponse> activateAccount({String email, String code});

  Future<PostResponse> setupAccount(
      {String gender,
      String city,
      String user_role,
      Map<String, dynamic> social_links});

  @mustCallSuper
  Future<void> signOut() async {
    setIsSignedIn = false;
    token = null;
  }
}
