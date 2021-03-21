import 'package:path_provider/path_provider.dart';

class PathUtil {
  static Future<String> get dataPath async {
    return (await getApplicationSupportDirectory()).path;
  }
}
