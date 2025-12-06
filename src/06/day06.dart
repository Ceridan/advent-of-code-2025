import '../lib/io.dart';

(List<String>, List<List<int>>, int) parseInput(String input) {
  var rows = <List<int>>[];
  var lines = input.split('\n').where((l) => l.isNotEmpty).toList();
  for (int i = 0; i < lines.length - 1; i++) {
    var row = <int>[];
    var line = lines[i].split(' ').where((l) => l.isNotEmpty).toList();
    for (var s in line) {
      row.add(int.parse(s));
    }
    rows.add(row);
  }

  var ops =
      lines[lines.length - 1].split(' ').where((l) => l.isNotEmpty).toList();
  return (ops, rows, rows[0].length);
}

part1(data) {
  var (ops, rows, n) = parseInput(data);
  var results = List<int>.generate(
    n,
    (idx) => ops[idx] == '*' ? 1 : 0,
    growable: false,
  );
  for (var row in rows) {
    for (int i = 0; i < row.length; i++) {
      if (ops[i] == '*') {
        results[i] *= row[i];
      } else {
        results[i] += row[i];
      }
    }
  }
  return results.reduce((acc, el) => acc + el);
}

part2(data) {
  return 0;
}

void main() async {
  final input = await FileUtils.readFileAsString('src/06/input.txt');

  print('Day 06, part1: ${part1(input)}');
  print('Day 06, part2: ${part2(input)}');
}
