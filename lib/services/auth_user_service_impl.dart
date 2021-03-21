import 'dart:convert';

import 'package:crowdfund_app/_utils/safe_print.dart';
import 'package:crowdfund_app/caching/app_shared_preferences_caching.dart';
import 'package:crowdfund_app/constants/api_path.dart';
import 'package:crowdfund_app/models/app_user_model.dart';
import 'package:crowdfund_app/services/auth_user_service.dart';
import 'package:dio/dio.dart';

class AuthenticationServiceImpl extends Authentication {
  String? token;

  /// TODO: Check if user is changed
  ///
  /// We can use shared preference and check if it doesn't contain false, then return the object of [User]
  ///
  ///```
  ///   FirebaseAuth.instance.userChanges().listen((User user) {
  ///   return _isSignedIn = user != null;
  ///   });
  ///```
  @override
  void init() async {
    PreferenceStore appPrefs = await PreferenceStore.create();
    if (appPrefs.getToken == null) {
      _isSignedIn = null;
    } else {
      _isSignedIn = true;
    }
  }

  bool? _isSignedIn = false;
  @override
  bool? get isSignedIn => _isSignedIn;

  @override
  Future<AppUser> signIn(
      {String? email, String? password, bool createAccount = false}) async {
    Dio dio = Dio();
    dio.options = BaseOptions(
        baseUrl: "http://192.168.56.1:5000/", responseType: ResponseType.json);
    Response? response;
    if (createAccount) {
      try {
        response = await dio.post(ApiPath.createAccount,
            data: {"email": email, "password": password});
      } catch (e) {}
    } else {
      try {
        response = await dio
            .post(ApiPath.signIn, data: {"email": email, "password": password});
      } on Exception catch (e) {
        safePrint(e.toString());
      }
    }

    return AppUser.fromJson(response?.data);
  }
}
