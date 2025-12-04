import '../lib/io.dart';

(Map<(int, int), String>, int, int) parseInput(String input) {
  var map = <(int, int), String>{};
  var lines = input.split('\n').where((l) => l.isNotEmpty).toList();
  var (ysize, xsize) = (lines.length, lines[0].length);

  for (int y = 0; y < ysize; y++) {
    var line = lines[y];
    for (int x = 0; x < xsize; x++) {
      map[(y, x)] = line[x];
    }
  }
  return (map, ysize, xsize);
}

(Map<(int, int), String>, int) calculateNextMap(map, ysize, xsize) {
  var newMap = <(int, int), String>{};
  var removedRolls = 0;
  for (int y = 0; y < ysize; y++) {
    for (int x = 0; x < xsize; x++) {
      if (map[(y, x)] == '.') {
        newMap[(y, x)] = '.';
        continue;
      }

      var adj = 0;
      for (int dy = -1; dy <= 1; dy++) {
        for (int dx = -1; dx <= 1; dx++) {
          if (dy == 0 && dx == 0) {
            continue;
          }
          var (ny, nx) = (y + dy, x + dx);
          if (ny == -1 || ny == ysize || nx == -1 || nx == xsize) {
            continue;
          }
          if (map[(ny, nx)] == '@') {
            adj++;
          }
        }
      }
      if (adj < 4) {
        newMap[(y, x)] = '.';
        removedRolls++;
      } else {
        newMap[(y, x)] = '@';
      }
    }
  }
  return (newMap, removedRolls);
}

part1(data) {
  var (map, ysize, xsize) = parseInput(data);
  var (_, removedRolls) = calculateNextMap(map, ysize, xsize);
  return removedRolls;
}

part2(data) {
  var (map, ysize, xsize) = parseInput(data);
  var totalRemovedRolls = 0;
  while (true) {
    var (newMap, removedRolls) = calculateNextMap(map, ysize, xsize);
    totalRemovedRolls += removedRolls;
    if (removedRolls == 0) {
      break;
    }
    map = newMap;
  }
  return totalRemovedRolls;
}

void main() async {
  final input = await FileUtils.readFileAsString('src/04/input.txt');

  print('Day 04, part1: ${part1(input)}');
  print('Day 04, part2: ${part2(input)}');
}
