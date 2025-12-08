import '../lib/io.dart';
import '../lib/point3d.dart';

class JoinedSet {
  final _groups = <int, Set<Point3D>>{};
  var _nextId = 0;

  add(Point3D p1, Point3D p2) {
    var k1 = -1;
    var k2 = -1;

    for (var entry in _groups.entries) {
      if (entry.value.contains(p1)) {
        k1 = entry.key;
      }
      if (entry.value.contains(p2)) {
        k2 = entry.key;
      }
    }

    if (k1 == -1 && k2 == -1) {
      _groups[_nextId++] = {p1, p2};
      return;
    }
    if (k1 == k2) {
      return;
    }

    if (k1 == -1) {
      _groups[k2]!.add(p1);
      return;
    }
    if (k2 == -1) {
      _groups[k1]!.add(p2);
      return;
    }

    _groups[k1] = _groups[k1]!.union(_groups[k2]!);
    _groups.remove(k2);
  }

  List<Set<Point3D>> list() {
    return _groups.values.toList();
  }

  int length() {
    return _groups.length;
  }
}

List<Point3D> parseBoxes(String input) {
  var lines = input.split('\n').where((l) => l.isNotEmpty).toList();
  var boxes = <Point3D>[];
  for (var line in lines) {
    var [x, y, z] = line.split(',').map(int.parse).toList();
    var point = Point3D(x, y, z);
    boxes.add(point);
  }
  return boxes;
}

Map<double, (Point3D, Point3D)> calculateDistances(List<Point3D> boxes) {
  var dist = <double, (Point3D, Point3D)>{};
  for (int i = 0; i < boxes.length - 1; i++) {
    for (int j = i + 1; j < boxes.length; j++) {
      var d = boxes[i].distance(boxes[j]);
      dist[d] = (boxes[i], boxes[j]);
    }
  }
  return dist;
}

JoinedSet connectN(List<Point3D> boxes, int connNum) {
  var joinedSet = JoinedSet();
  var dist = calculateDistances(boxes);
  var distVals = dist.keys.toList();
  distVals.sort();
  for (int i = 0; i < connNum; i++) {
    var (p1, p2) = dist[distVals[i]]!;
    joinedSet.add(p1, p2);
  }
  return joinedSet;
}

(Point3D, Point3D) connectAll(List<Point3D> boxes) {
  var joinedSet = JoinedSet();
  var dist = calculateDistances(boxes);
  var distVals = dist.keys.toList();
  distVals.sort();
  int i = 0;
  while (true) {
    var (p1, p2) = dist[distVals[i++]]!;
    joinedSet.add(p1, p2);

    if (joinedSet.length() == 1 && joinedSet.list()[0].length == boxes.length) {
      return (p1, p2);
    }
  }
}

part1(data, connections) {
  var boxes = parseBoxes(data);
  var joinedSet = connectN(boxes, connections);
  var sizes = joinedSet.list().map((g) => g.length).toList();
  sizes.sort((a, b) => b - a);
  return sizes.take(3).reduce((acc, val) => acc * val);
}

part2(data) {
  var boxes = parseBoxes(data);
  var (p1, p2) = connectAll(boxes);
  return p1.x * p2.x;
}

void main() async {
  final input = await FileUtils.readFileAsString('src/08/input.txt');

  print('Day 08, part1: ${part1(input, 1000)}');
  print('Day 08, part2: ${part2(input)}');
}
