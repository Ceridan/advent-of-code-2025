import 'dart:collection';
import 'dart:math' as math;
import '../lib/io.dart';

((int, int), Set<(int, int)>) parseTachyonManfiolds(String data) {
  Set<(int, int)> splitters = {};
  var start = (0, 0);
  var lines = data.split('\n').where((l) => l.isNotEmpty).toList();
  for (int y = 0; y < lines.length; y++) {
    var line = lines[y];
    for (int x = 0; x < line.length; x++) {
      switch (line[x]) {
        case '^':
          splitters.add((y, x));
        case 'S':
          start = (y, x);
      }
    }
  }
  return (start, splitters);
}

(int, int, int, int) getBorders(Set<(int, int)> splitters) {
  var minY = splitters.map((s) => s.$1).reduce(math.min);
  var maxY = splitters.map((s) => s.$1).reduce(math.max);
  var minX = splitters.map((s) => s.$2).reduce(math.min);
  var maxX = splitters.map((s) => s.$2).reduce(math.max);
  return (minY, maxY, minX, maxX);
}

int countSplits(Set<(int, int)> splitters, (int, int) start) {
  var (minY, maxY, minX, maxX) = getBorders(splitters);
  var counter = 0;
  Set<(int, int)> visited = {};
  var queue = Queue<(int, int)>.from([start]);
  while (queue.length > 0) {
    var (y, x) = queue.removeFirst();
    if (visited.contains((y, x))) {
      continue;
    }
    visited.add((y, x));

    if (y > maxY || x < minX || x > maxX) {
      continue;
    }
    if (splitters.contains((y, x))) {
      counter++;
      queue.add((y + 1, x - 1));
      queue.add((y + 1, x + 1));
    } else {
      queue.add((y + 1, x));
    }
  }
  return counter;
}

part1(data) {
  var (start, splitters) = parseTachyonManfiolds(data);
  return countSplits(splitters, start);
}

part2(data) {
  return 0;
}

void main() async {
  final input = await FileUtils.readFileAsString('src/07/input.txt');

  print('Day 07, part1: ${part1(input)}');
  print('Day 07, part2: ${part2(input)}');
}
