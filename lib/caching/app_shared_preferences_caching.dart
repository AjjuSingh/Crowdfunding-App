import 'dart:convert';

import 'package:crowdfund_app/models/app_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceStore {
  static Future<PreferenceStore> create() async =>
      PreferenceStore._internal(await SharedPreferences.getInstance());

  SharedPreferences _prefs;
  PreferenceStore._internal(this._prefs);

  Future<bool> setToken(String token) {
    return _prefs.setString("token", token);
  }

  String? get getToken => _prefs.getString("token");

  Future<bool> removeToken() async {
    return _prefs.remove('token');
  }

  Future<bool> setCurrentUser(AppUser user) async {
    Map<String, dynamic> json = user.toJson();
    String userSerialized = jsonEncode(AppUser.fromJson(json));
    return _prefs.setString("currentUser", userSerialized);
  }

  AppUser get getCurrentUser {
    return AppUser.fromJson(jsonDecode(_prefs.getString("currentUser")!));
  }

  Future<bool> removeCurrentUser() async {
    return _prefs.remove("currentUser");
  }
}
