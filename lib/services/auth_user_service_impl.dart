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
  late PreferenceStore appPrefs;

  /// We can use shared preference and check if it doesn't contain false, then
  /// return the object of [User]
  @override
  void init() async {
    safePrint("Initialized authentication service");
    dio.options = BaseOptions(
        baseUrl: APIConstants.prodUrl,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: true);
    appPrefs = await PreferenceStore.create();
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
      // Create account if [bool] is true
      if (createAccount) {
        response = await dio.post(ApiPath.createAccount, data: {
          "email": email,
          "password": password,
          "confirmPassword": password
        });
      } else {
        response = await dio.post(ApiPath.signIn,
            data: {"email": email, "password": password},
            options: Options(
              followRedirects: false,
              receiveDataWhenStatusError: true,
              validateStatus: (status) {
                return status! == 200;
              },
            ));
      }
    } on DioError catch (err) {
      safePrint(err.response!.data.toString());
      return Left(PostResponse.fromJson(err.response!.data));
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
    } on DioError catch (err) {
      return PostResponse.fromJson(err.response!.data);
    }
    return PostResponse.fromJson(response.data);
  }

  @override
  Future<PostResponse> setupAccount(
      {String? gender,
      String? city,
      String? user_role,
      Map<String, dynamic>? social_links}) async {
    Response? response;

    try {
      print("Token is");
      print(appPrefs.getToken);
      response = await dio.post(
        ApiPath.profileBasic,
        options: Options(
            responseType: ResponseType.json,
            headers: {"Authorization": "Bearer ${appPrefs.getToken}"}),
        data: {
          "gender": gender!,
          "city": city!,
          "user_role": user_role!,
          "social_links": social_links
        },
      );
    } on DioError catch (err) {
      safePrint(err.message);
      return PostResponse.fromJson(err.response!.data);
    }
    return PostResponse.fromJson(response.data);
  }
}
