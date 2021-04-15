import 'package:crowdfund_app/_utils/debouncer.dart';
import 'package:crowdfund_app/_utils/easy_notifier.dart';
import 'package:crowdfund_app/caching/app_shared_preferences_caching.dart';
import 'package:crowdfund_app/models/app_user_model.dart';
import 'package:crowdfund_app/services/auth_user_service.dart';

abstract class AbstractModel extends EasyNotifier {}

class AppModel extends AbstractModel {
  static const kFileName = "app-model";
  static const kVersion = "1.0.0";

  AppModel(this._authentication);

  // State
  Debouncer _saveDebouncer = Debouncer(Duration(seconds: 1));
  Authentication _authentication;

  /// Startup
  bool _hasBootstrapped = false;
  bool get hasBootstrapped => _hasBootstrapped;
  set hasBootstrapped(bool value) => notify(() => _hasBootstrapped = value);

  void reset() async {
    PreferenceStore store = await PreferenceStore.create();
    await store.removeCurrentUser();
    await store.removeToken();
    _currentUser = null;
    _authentication.token = null;
    print("Reset appmode: currentUser = $_currentUser");
  }

  void save() async {
    print("Saving: $kFileName");

    PreferenceStore store = await PreferenceStore.create();

    store.setToken(tokenToString()!);
    store.setCurrentUser(_currentUser!);
  }

  Future<void> load() async {
    PreferenceStore store = await PreferenceStore.create();
    String? saveJson = store.getToken;
    _currentUser = store.getCurrentUser;
    try {
      fromJson(saveJson);
    } catch (e) {
      print("Failed to decode save file json: $e");
    }
  }

  /// Auth state
  // Current user
  AppUser? _currentUser;
  AppUser? get currentUser => _currentUser;
  set currentUser(AppUser? user) => notify(() => _currentUser = user);

  bool? get isSignedIn => _authentication.isSignedIn;

  bool get hasUser => currentUser != null;
  bool get isAuthenticated => hasUser && isSignedIn!;
  String? get currentUserToken => currentUser!.accessToken;

  void fromJson(String? token) {
    _currentUser?.accessToken = token != null ? token : null;
  }

  String? tokenToString() {
    return _currentUser?.accessToken;
  }
}
