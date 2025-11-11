import 'dart:io';

class FileUtils {
  static Future<String> readFileAsString(String filePath) async {
    final asyncFn = () => File(filePath).readAsString();
    return _runOrExit(asyncFn);
  }

  static Future<List<String>> readFileAsLines(String filePath) async {
    final asyncFn = () => File(filePath).readAsLines();
    return _runOrExit(asyncFn);
  }

  static Future<T> _runOrExit<T>(Future<T> Function() asyncFn) async {
    try {
      return await asyncFn();
    } catch (e) {
      print('Error reading file: $e');
      exit(1);
    }
  }
}
