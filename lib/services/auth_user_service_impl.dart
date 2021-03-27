import 'dart:convert';

import 'package:crowdfund_app/_utils/exceptions/bad_request_exception.dart';
import 'package:crowdfund_app/_utils/safe_print.dart';
import 'package:crowdfund_app/caching/app_shared_preferences_caching.dart';
import 'package:crowdfund_app/constants/api_path.dart';
import 'package:crowdfund_app/models/app_user_model.dart';
import 'package:crowdfund_app/models/response/post_response_model.dart';
import 'package:crowdfund_app/services/auth_user_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthenticationServiceImpl extends Authentication {
  String? token;

  Dio dio = Dio();

  /// We can use shared preference and check if it doesn't contain false, then
  /// return the object of [User]
  @override
  void init() async {
    dio.options = BaseOptions(
        baseUrl: "http://192.168.50.107:5000/",
        responseType: ResponseType.json);
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
  Future<Either<PostResponse, AppUser>> signIn(
      {String? email, String? password, bool createAccount = false}) async {
    Response? response;
    try {
      if (createAccount) {
        try {
          response = await dio.post(ApiPath.createAccount, data: {
            "email": email,
            "password": password,
            "confirmPassword": password
          });
        } catch (err) {
          return Left(PostResponse.fromJson(response!.data));
        }
      } else {
        response = await dio
            .post(ApiPath.signIn, data: {"email": email, "password": password});
      }
    } on BadRequestException catch (_) {
      return Left(PostResponse.fromJson(response!.data));
    }
    return Right(AppUser.fromJson(response.data));
  }

  @override
  Future<PostResponse> activateAccount({String? email, String? code}) async {
    Response? response;
    try {
      safePrint("Activate account for $email");
      response = await dio.patch(
        ApiPath.activateAccount,
        options: Options(responseType: ResponseType.json),
        data: {"email": email!, "code": code!},
      );
    } on BadRequestException catch (_) {}
    return PostResponse.fromJson(response!.data);
  }
}
