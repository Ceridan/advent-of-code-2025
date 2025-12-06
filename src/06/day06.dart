import '../lib/io.dart';

(List<String>, List<List<int>>) parseByRow(String input) {
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
  return (ops, rows);
}

(List<String>, List<List<int>>) parseByColumn(String input) {
  var lines = input.split('\n').where((l) => l.isNotEmpty).toList();
  var sizes = <int>[];
  var ops = <String>[];
  var lastLine = lines[lines.length - 1];
  var k = 0;
  for (int i = 0; i < lastLine.length; i++) {
    if (lastLine[i] == ' ') {
      k++;
    } else {
      ops.add(lastLine[i]);
      if (i > 0) {
        sizes.add(k);
      }
      k = 0;
    }
  }
  sizes.add(k + 1);

  var nums = <List<int>>[];
  for (int j = 0; j < sizes.length; j++) {
    nums.add(List<int>.filled(sizes[j], 0, growable: false));
  }
  for (int i = 0; i < lines.length - 1; i++) {
    var shift = 0;
    for (int j = 0; j < sizes.length; j++) {
      for (int k = 0; k < sizes[j]; k++) {
        if (shift + k == lines[i].length) {
          break;
        }
        var ch = lines[i][shift + k];
        if (ch != ' ') {
          nums[j][k] = nums[j][k] * 10 + int.parse(ch);
        }
      }
      shift = shift + sizes[j] + 1;
    }
  }

  return (ops, nums);
}

part1(data) {
  var (ops, nums) = parseByRow(data);
  var results = List<int>.generate(
    nums[0].length,
    (idx) => ops[idx] == '*' ? 1 : 0,
    growable: false,
  );
  for (var row in nums) {
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
  var (ops, nums) = parseByColumn(data);
  var grandTotal = 0;
  for (int i = 0; i < nums.length; i++) {
    if (ops[i] == '*') {
      grandTotal += nums[i].reduce((acc, el) => acc * el);
    } else {
      grandTotal += nums[i].reduce((acc, el) => acc + el);
    }
  }
  return grandTotal;
}

void main() async {
  final input = await FileUtils.readFileAsString('src/06/input.txt');

  print('Day 06, part1: ${part1(input)}');
  print('Day 06, part2: ${part2(input)}');
}
