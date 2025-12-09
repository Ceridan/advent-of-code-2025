import 'dart:math' as math;
import '../lib/io.dart';
import '../lib/point.dart';

List<Point> parseInput(String input) {
  var points = <Point>[];
  var lines = input.split('\n').where((l) => l.isNotEmpty).toList();
  for (var line in lines) {
    var [x, y] = line.split(',');
    points.add(Point(int.parse(x), int.parse(y)));
  }
  return points;
}

part1(data) {
  var points = parseInput(data);
  var area = 0;
  for (int i = 0; i < points.length - 1; i++) {
    for (int j = i + 1; j < points.length; j++) {
      var px = (points[i].x - points[j].x).abs() + 1;
      var py = (points[i].y - points[j].y).abs() + 1;
      area = math.max(area, px * py);
    }
  }
  return area;
}

part2(data) {
  return 0;
}

void main() async {
  final input = await FileUtils.readFileAsString('src/09/input.txt');

  print('Day 09, part1: ${part1(input)}');
  print('Day 09, part2: ${part2(input)}');
}
