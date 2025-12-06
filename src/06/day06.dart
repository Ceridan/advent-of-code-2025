import 'dart:math' as math;
import '../lib/io.dart';

(List<List<String>>, List<String>) readAsMatrixAndOps(String data) {
  var lines = data.split('\n').where((l) => l.isNotEmpty).toList();
  var longest = lines.map((l) => l.length).reduce(math.max);
  var matrix = <List<String>>[];
  for (int r = 0; r < lines.length - 1; r++) {
    var cols = <String>[];
    for (int c = 0; c < longest; c++) {
      var ch = c < lines[r].length ? lines[r][c] : ' ';
      cols.add(ch);
    }
    matrix.add(cols);
  }

  var ops =
      lines[lines.length - 1].split(' ').where((l) => l.isNotEmpty).toList();
  return (matrix, ops);
}

List<List<int>> parseNumbersByRow(List<List<String>> matrix, int n) {
  var nums = List<List<int>>.generate(n, (idx) => []);
  for (var row in matrix) {
    var rowNums = row
        .join()
        .split(' ')
        .where((r) => r.isNotEmpty)
        .map((v) => int.parse(v))
        .toList();
    for (int i = 0; i < n; i++) {
      nums[i].add(rowNums[i]);
    }
  }
  return nums;
}

List<List<int>> parseNumbersByColumn(List<List<String>> matrix, int n) {
  var nums = List<List<int>>.generate(n, (idx) => []);
  var k = 0;
  for (int c = 0; c < matrix[0].length; c++) {
    var val = 0;
    for (int r = 0; r < matrix.length; r++) {
      if (matrix[r][c] != ' ') {
        val = val * 10 + int.parse(matrix[r][c]);
      }
    }
    if (val > 0) {
      nums[k].add(val);
    } else {
      k++;
    }
  }
  return nums;
}

int applyOpertaion(List<int> nums, String op) {
  if (op == '*') {
    return nums.reduce((acc, val) => acc * val);
  } else {
    return nums.reduce((acc, val) => acc + val);
  }
}

int calculateGrandTotal(List<List<int>> nums, List<String> ops) {
  var grandTotal = 0;
  for (int i = 0; i < ops.length; i++) {
    grandTotal += applyOpertaion(nums[i], ops[i]);
  }
  return grandTotal;
}

part1(data) {
  var (matrix, ops) = readAsMatrixAndOps(data);
  var nums = parseNumbersByRow(matrix, ops.length);
  return calculateGrandTotal(nums, ops);
}

part2(data) {
  var (matrix, ops) = readAsMatrixAndOps(data);
  var nums = parseNumbersByColumn(matrix, ops.length);
  return calculateGrandTotal(nums, ops);
}

void main() async {
  final input = await FileUtils.readFileAsString('src/06/input.txt');

  print('Day 06, part1: ${part1(input)}');
  print('Day 06, part2: ${part2(input)}');
}
