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

int countSplits(Set<(int, int)> splitters, (int, int) start, int maxY) {
  var counter = 0;
  Set<(int, int)> visited = {};
  var queue = Queue<(int, int)>.from([start]);
  while (queue.length > 0) {
    var (y, x) = queue.removeFirst();
    if (visited.contains((y, x))) {
      continue;
    }
    visited.add((y, x));

    if (y > maxY) {
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

int countTimelines(Set<(int, int)> splitters, (int, int) pos, int maxY,
    Map<(int, int), int> cache) {
  if (cache.containsKey(pos)) {
    return cache[pos]!;
  }

  var (y, x) = pos;
  if (y > maxY) {
    return 1;
  }

  var counter = 0;
  if (splitters.contains((y, x))) {
    counter = countTimelines(splitters, (y + 1, x - 1), maxY, cache) +
        countTimelines(splitters, (y + 1, x + 1), maxY, cache);
  } else {
    counter = countTimelines(splitters, (y + 1, x), maxY, cache);
  }

  cache[(y, x)] = counter;
  return counter;
}

part1(data) {
  var (start, splitters) = parseTachyonManfiolds(data);
  var maxY = splitters.map((s) => s.$1).reduce(math.max);
  return countSplits(splitters, start, maxY);
}

part2(data) {
  var (start, splitters) = parseTachyonManfiolds(data);
  var maxY = splitters.map((s) => s.$1).reduce(math.max);
  return countTimelines(splitters, start, maxY, {});
}

void main() async {
  final input = await FileUtils.readFileAsString('src/07/input.txt');

  print('Day 07, part1: ${part1(input)}');
  print('Day 07, part2: ${part2(input)}');
}
