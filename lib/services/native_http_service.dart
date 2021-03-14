import 'dart:convert';

import 'package:crowdfund_app/services/http_service.dart';
import 'package:crowdfund_app/services/token_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NativeHttpService extends HttpService {}

class PreferenceStore extends TokenStore {
  static const authToken = "auth_token";

  static Future<PreferenceStore> create() async =>
      PreferenceStore._internal(await SharedPreferences.getInstance());

  SharedPreferences _prefs;
  PreferenceStore._internal(this._prefs);

  @override
  void delete() {
    _prefs.remove(authToken);
  }

  @override
  Token? read() {
    _prefs.containsKey(authToken)
        ? Token.fromMap(json.decode(_prefs.get(authToken) as String))
        : null;
  }

  @override
  void write(Token? token) {
    _prefs.setString(authToken, json.encode(token!.toMap()));
  }
}
