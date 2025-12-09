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
  var area = 0;
  for (int i = 0; i < points.length - 1; i++) {
    for (int j = i + 1; j < points.length; j++) {
      var (p1, p2) = (points[i], points[j]);

      // for (int dx = math.min(p1.x, p2.x); dx <= math.max(p1.x, p2.x); dx++) {
      //   if (!checkRayCasting(Point(dx, p1.y), points, minPoint, maxPoint)) {
      //     continue outerLoop;
      //   }
      //
      //   if (!checkRayCasting(Point(dx, p2.y), points, minPoint, maxPoint)) {
      //     continue outerLoop;
      //   }
      // }
      // for (int dy = math.min(p1.y, p2.y); dy <= math.max(p1.y, p2.y); dy++) {
      //   if (!checkRayCasting(Point(p1.x, dy), points, minPoint, maxPoint)) {
      //     continue outerLoop;
      //   }
      //
      //   if (!checkRayCasting(Point(p2.x, dy), points, minPoint, maxPoint)) {
      //     continue outerLoop;
      //   }
      // }
      var p12 = Point(p1.x, p2.y);
      if (!checkRayCasting(p12, points, minPoint, maxPoint)) {
        continue;
      }

      var p21 = Point(p2.x, p1.y);
      if (!checkRayCasting(p21, points, minPoint, maxPoint)) {
        continue;
      }

      var pm = Point((p1.x + p2.x) ~/ 2, (p1.y + p2.y) ~/ 2);
      if (!checkRayCasting(pm, points, minPoint, maxPoint)) {
        continue;
      }
      var px = (p1.x - p2.x).abs() + 1;
      var py = (p1.y - p2.y).abs() + 1;
      area = math.max(area, px * py);
    }
  }
  return area;
}

void main() async {
  final input = await FileUtils.readFileAsString('src/09/input.txt');

  print('Day 09, part1: ${part1(input)}');
  print('Day 09, part2: ${part2(input)}');
}

// 4595056840 - too high
// 4532204600 - too high
