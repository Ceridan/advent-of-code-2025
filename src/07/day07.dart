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
  var visited = <(int, int), int>{};
  var _ = countTimelines(splitters, start, maxY, visited);
  var splits = splitters.intersection(visited.keys.toSet());
  return splits.length;
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
