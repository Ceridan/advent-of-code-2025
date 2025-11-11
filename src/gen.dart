import 'dart:io';
import 'package:http/http.dart' as http;
import 'lib/io.dart';

void main(List<String> args) async {
  if (args.isEmpty) {
    print('Day should be provided as an argument.');
    exit(1);
  }

  var day = args[0];

  // Create directory for the next day.
  await FileUtils.createDirectory('src/$day/');

  // Code file template.
  var codeTemplate = """import '../lib/io.dart';

part1(data) {
  return 0;
}

part2(data) {
  return 0;
}

void main() async {
  final input = await FileUtils.readFileAsString('src/$day/input.txt');

  print('Day $day, part1: \${part1(input)}');
  print('Day $day, part2: \${part2(input)}');
}
""";
  var codeFileName = 'src/$day/day$day.dart';
  await FileUtils.createFile(codeFileName, codeTemplate);

  // Test file template.
  var testTemplate = """import 'package:test/test.dart';
import 'day$day.dart';

void main() {
  group('Part1', () {
    test('sample', () {
      expect(part1("test"), equals(0));
    });
  });

  group('Part2', () {
    test('sample', () {
      expect(part2("test"), equals(0));
    });
  });
}
""";
  var testFileName = 'src/$day/day${day}_test.dart';
  await FileUtils.createFile(testFileName, testTemplate);

  // Download input.
  var headers = {
    'cookie': 'session=${Platform.environment['AOC_SESSION']}',
  };
  var url = Uri.https('adventofcode.com', '2025/day/${int.parse(day)}/input');
  var response = await http.get(url, headers: headers);
  if (response.statusCode != 200) {
    print('Cannot download import: ${response.body}');
    exit(1);
  }
  var inputFileName = 'src/$day/input.txt';
  await FileUtils.createFile(inputFileName, response.body);

  // Add to git.
  var git = await Process.start(
      'git', ['add', codeFileName, testFileName, inputFileName],
      runInShell: true);
  var exitCode = await git.exitCode;
  if (exitCode != 0) {
    print('Error while executing "git add"');
    exit(1);
  }

  print('Done.');
}
