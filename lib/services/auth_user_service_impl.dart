import 'dart:convert';

import 'package:crowdfund_app/_utils/exceptions/bad_request_exception.dart';
import 'package:crowdfund_app/_utils/safe_print.dart';
import 'package:crowdfund_app/caching/app_shared_preferences_caching.dart';
import 'package:crowdfund_app/constants/api_path.dart';
import 'package:crowdfund_app/models/app_user_model.dart';
import 'package:crowdfund_app/services/auth_user_service.dart';
import 'package:dartz/dartz.dart';
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
  Future<Either<BadRequestException, AppUser>> signIn(
      {String? email, String? password, bool createAccount = false}) async {
    Dio dio = Dio();
    dio.options = BaseOptions(
        baseUrl: "http://192.168.50.135:5000/",
        responseType: ResponseType.json);
    Response? response;
    try {
      if (createAccount) {
        response = await dio.post(ApiPath.createAccount,
            data: {"email": email, "password": password});
      } else {
        response = await dio
            .post(ApiPath.signIn, data: {"email": email, "password": password});
      }
    } on BadRequestException catch (_) {
      return Left(BadRequestException("Some error occured", true));
    }
    return Right(AppUser.fromJson(response.data));
  }
}
