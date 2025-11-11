import 'dart:io';

class FileUtils {
  static Future<String> readFileAsString(String filePath) async {
    var asyncFn = () => File(filePath).readAsString();
    return _runOrExit(asyncFn);
  }

  static Future<List<String>> readFileAsLines(String filePath) async {
    var asyncFn = () => File(filePath).readAsLines();
    return _runOrExit(asyncFn);
  }

  static Future<void> createDirectory(String directoryPath) async {
    try {
      Directory directory = Directory(directoryPath);

      if (await directory.exists()) {
        print('Directory already exists: $directoryPath');
        exit(1);
      }

      await directory.create();
    } catch (e) {
      print('Error creating directory: $e');
      exit(1);
    }
  }

  static Future<void> createFile(String fileName, String content) async {
    try {
      var file = File(fileName);
      var fileSink = file.openWrite();
      fileSink.write(content);
      await fileSink.flush();
      await fileSink.close();
    } catch (e) {
      print('Error writing file: $e');
      exit(1);
    }
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
