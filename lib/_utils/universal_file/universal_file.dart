import 'dart:async';

import 'package:crowdfund_app/_utils/universal_file/universal_file_locator.dart';

abstract class UniversalFile {
  String? fileName;
  Future<void> write(String value, [bool append = false]);
  Future<String?> read();

  factory UniversalFile(String fileName) => getPlatformFileWriter(fileName);
}
