import 'universal_file.dart';
import 'dart:io';

UniversalFile getPlatformFileWriter(String fileName) => throw UnsupportedError(
    'Cannot create a fileWriter for "$fileName" without the packages dart:html or dart:io');
