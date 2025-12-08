import 'dart:math' as math;
import '../lib/io.dart';
import '../lib/point3d.dart';

Map<Point3D, int> parseBoxes(String input) {
  var lines = input.split('\n').where((l) => l.isNotEmpty).toList();
  var map = <Point3D, int>{};
  for (int i = 0; i < lines.length; i++) {
    var [x, y, z] = lines[i].split(',').map(int.parse).toList();
    var point = Point3D(x, y, z);
    map[point] = i;
  }
  return map;
}

Map<(Point3D, Point3D), double> calculateDistances(List<Point3D> boxes) {
  var dist = <(Point3D, Point3D), double>{};
  for (int i = 0; i < boxes.length - 1; i++) {
    for (int j = i + 1; j < boxes.length; j++) {
      dist[(boxes[i], boxes[j])] = boxes[i].distance(boxes[j]);
    }
  }
  return dist;
}

connect(Map<Point3D, int> boxes, Map<(Point3D, Point3D), double> dist,
    int connNum) {
  var invertedDist = <double, (Point3D, Point3D)>{};
  dist.forEach((key, value) => invertedDist[value] = key);
  print(
      'boxes = ${boxes.length}, dist = ${dist.length}, inv = ${invertedDist.length}');
  var distVals = dist.values.toList();
  distVals.sort();
  for (int i = 0; i < connNum; i++) {
    var (p1, p2) = invertedDist[distVals[i]]!;
    var id = math.min(boxes[p1]!, boxes[p2]!);
    for (var p in boxes.keys) {
      if (boxes[p] == boxes[p1] || boxes[p] == boxes[p2]) {
        boxes[p] = id;
      }
    }
  }
}

Map<int, Set<Point3D>> connect2(Map<Point3D, int> boxes,
    Map<(Point3D, Point3D), double> dist, int connNum) {
  var groups = <int, Set<Point3D>>{};
  var invertedDist = <double, (Point3D, Point3D)>{};
  dist.forEach((key, value) => invertedDist[value] = key);
  print(
      'boxes = ${boxes.length}, dist = ${dist.length}, inv = ${invertedDist.length}');
  var distVals = dist.values.toList();
  distVals.sort();
  for (int i = 0; i < connNum; i++) {
    var (p1, p2) = invertedDist[distVals[i]]!;
    var k1 = -1;
    var k2 = -1;

    for (var entry in groups.entries) {
      if (entry.value.contains(p1)) {
        k1 = entry.key;
      }
      if (entry.value.contains(p2)) {
        k2 = entry.key;
      }
    }

    if (k1 == -1 && k2 == -1) {
      groups[math.min(boxes[p1]!, boxes[p2]!)] = {p1, p2};
      continue;
    }
    if (k1 == k2) {
      continue;
    }

    if (k1 == -1) {
      groups[k2]!.add(p1);
      continue;
    }

    if (k2 == -1) {
      groups[k1]!.add(p2);
      continue;
    }

    groups[k1] = groups[k1]!.union(groups[k2]!);
    groups.remove(k2);
  }
  return groups;
}

Map<int, int> calculateFrequences(Map<Point3D, int> boxes) {
  var freq = <int, int>{};
  for (var val in boxes.values) {
    freq.update(val, (count) => count + 1, ifAbsent: () => 1);
  }
  return freq;
}

part1(data, connections) {
  var boxes = parseBoxes(data);
  var dist = calculateDistances(boxes.keys.toList());
  var groups = connect2(boxes, dist, connections);
  var sizes = groups.values.map((g) => g.length).toList();
  sizes.sort((a, b) => b - a);
  return sizes.take(3).reduce((acc, val) => acc * val);
  // connect(boxes, dist, connections);
  // var freqs = calculateFrequences(boxes);
  // var values = freqs.values.toList();
  // values.sort((a, b) => b - a);
  // return values.take(3).reduce((acc, val) => acc * val);
}

part2(data) {
  return 0;
}

void main() async {
  final input = await FileUtils.readFileAsString('src/08/input.txt');

  print('Day 08, part1: ${part1(input, 1000)}');
  print('Day 08, part2: ${part2(input)}');
}

// 13920 - too low
