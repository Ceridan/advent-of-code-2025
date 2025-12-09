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

(Point, Point) getBoundaries(List<Point> points) {
  int minX = 1000000;
  int maxX = -1;
  int minY = 1000000;
  int maxY = -1;

  for (var p in points) {
    minX = math.min(minX, p.x);
    maxX = math.max(maxX, p.x);
    minY = math.min(minY, p.y);
    maxY = math.max(maxY, p.y);
  }
  return (Point(minX, minY), Point(maxX, maxY));
}

bool checkSegment(Point testPoint, Point s1, Point s2) {
  if (testPoint.x == s1.x && testPoint.x == s2.x) {
    return (testPoint.y >= math.min(s1.y, s2.y) &&
        testPoint.y <= math.max(s1.y, s2.y));
  } else if (testPoint.y == s1.y && testPoint.y == s2.y) {
    return (testPoint.x >= math.min(s1.x, s2.x) &&
        testPoint.x <= math.max(s1.x, s2.x));
  }
  return false;
}

bool checkRayCasting(
    Point testPoint, List<Point> points, Point minPoint, Point maxPoint) {
  if (testPoint.x < minPoint.x ||
      testPoint.x > maxPoint.x ||
      testPoint.y < minPoint.y ||
      testPoint.y > maxPoint.y) {
    return false;
  }

  int intersections = 0;
  for (int i = 0; i < points.length; i++) {
    var p1 = points[i];
    var p2 = points[(i + 1) % points.length];

    if (checkSegment(testPoint, p1, p2)) {
      return true;
    }

    if (p1.x != p2.x) {
      continue;
    }

    if (p1.x > testPoint.x &&
        ((p1.y <= testPoint.y && testPoint.y < p2.y) ||
            (p2.y <= testPoint.y && testPoint.y < p1.y))) {
      intersections++;
    }
  }

  return intersections % 2 == 1;
}

bool checkSegmentIntersection(Point rp1, Point rp2, List<Point> points) {
  var minX = math.min(rp1.x, rp2.x);
  var maxX = math.max(rp1.x, rp2.x);
  var minY = math.min(rp1.y, rp2.y);
  var maxY = math.max(rp1.y, rp2.y);

  for (int i = 0; i < points.length; i++) {
    var p1 = points[i];
    var p2 = points[(i + 1) % points.length];

    if (p1.x == p2.x) {
      var pMin = math.min(p1.y, p2.y);
      var pMax = math.max(p1.y, p2.y);

      if (minX < p1.x && p1.x < maxX) {
        var start = math.max(minY, pMin);
        var end = math.min(maxY, pMax);
        if (start < end) {
          return false;
        }
      }
    }

    if (p1.y == p2.y) {
      var pMin = math.min(p1.x, p2.x);
      var pMax = math.max(p1.x, p2.x);

      if (minY < p1.y && p1.y < maxY) {
        var start = math.max(minX, pMin);
        var end = math.min(maxX, pMax);
        if (start < end) {
          return false;
        }
      }
    }
  }
  return true;
}

part1(data) {
  var points = parseInput(data).toList();
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
  var points = parseInput(data);
  var (minPoint, maxPoint) = getBoundaries(points);
  var largestArea = 0;
  for (int i = 0; i < points.length - 1; i++) {
    for (int j = i + 1; j < points.length; j++) {
      var (p1, p2) = (points[i], points[j]);
      var px = (p1.x - p2.x).abs() + 1;
      var py = (p1.y - p2.y).abs() + 1;
      var area = px * py;
      if (area <= largestArea) {
        continue;
      }
      if (!checkSegmentIntersection(p1, p2, points)) {
        continue;
      }
      largestArea = area;
    }
  }
  return largestArea;
}

void main() async {
  final input = await FileUtils.readFileAsString('src/09/input.txt');

  print('Day 09, part1: ${part1(input)}');
  print('Day 09, part2: ${part2(input)}');
}
