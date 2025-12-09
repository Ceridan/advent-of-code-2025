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

bool checkSegmentIntersection(
    Point rectPoint1, Point rectPoint2, List<Point> points) {
  var rectMinX = math.min(rectPoint1.x, rectPoint2.x);
  var rectMaxX = math.max(rectPoint1.x, rectPoint2.x);
  var rectMinY = math.min(rectPoint1.y, rectPoint2.y);
  var rectMaxY = math.max(rectPoint1.y, rectPoint2.y);

  for (int i = 0; i < points.length; i++) {
    var p1 = points[i];
    var p2 = points[(i + 1) % points.length];

    if (p1.x == p2.x) {
      var minY = math.min(p1.y, p2.y);
      var maxY = math.max(p1.y, p2.y);

      if (rectMinX < p1.x && p1.x < rectMaxX) {
        var start = math.max(rectMinY, minY);
        var end = math.min(rectMaxY, maxY);
        if (start < end) {
          return false;
        }
      }
    }

    if (p1.y == p2.y) {
      var minX = math.min(p1.x, p2.x);
      var maxX = math.max(p1.x, p2.x);

      if (rectMinY < p1.y && p1.y < rectMaxY) {
        var start = math.max(rectMinX, minX);
        var end = math.min(rectMaxX, maxX);
        if (start < end) {
          return false;
        }
      }
    }
  }
  return true;
}

int calculateMaxArea(List<Point> points, bool Function(Point, Point) condFn) {
  var largestArea = 0;
  for (int i = 0; i < points.length - 1; i++) {
    for (int j = i + 1; j < points.length; j++) {
      var px = (points[i].x - points[j].x).abs() + 1;
      var py = (points[i].y - points[j].y).abs() + 1;
      var area = px * py;
      if (area <= largestArea) {
        continue;
      }
      if (!condFn(points[i], points[j])) {
        continue;
      }
      largestArea = area;
    }
  }
  return largestArea;
}

part1(data) {
  var points = parseInput(data).toList();
  var condFn = (p1, p2) => true;
  return calculateMaxArea(points, condFn);
}

part2(data) {
  var points = parseInput(data);
  var condFn = (p1, p2) => checkSegmentIntersection(p1, p2, points);
  return calculateMaxArea(points, condFn);
}

void main() async {
  final input = await FileUtils.readFileAsString('src/09/input.txt');

  print('Day 09, part1: ${part1(input)}');
  print('Day 09, part2: ${part2(input)}');
}
