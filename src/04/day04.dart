import '../lib/io.dart';

(Map<(int, int), String>, int, int) parseInput(String input) {
  var map = <(int, int), String>{};
  var lines = input.split('\n').where((l) => l.isNotEmpty).toList();
  var (ysize, xsize) = (lines.length, lines[0].length);

  for (int x = -1; x <= xsize; x++) {
    map[(-1, x)] = '.';
    map[(ysize, x)] = '.';
  }

  for (int y = -1; y <= ysize; y++) {
    map[(y, -1)] = '.';
    map[(y, xsize)] = '.';
  }

  for (int y = 0; y < ysize; y++) {
    var line = lines[y];
    for (int x = 0; x < xsize; x++) {
      map[(y, x)] = line[x];
    }
  }
  return (map, ysize, xsize);
}

part1(data) {
  var (map, ysize, xsize) = parseInput(data);
  var rolls = 0;
  for (int y = 0; y < ysize; y++) {
    for (int x = 0; x < xsize; x++) {
      if (map[(y, x)] == '.') {
        continue;
      }

      var adj = 0;
      for (int dy = -1; dy <= 1; dy++) {
        for (int dx = -1; dx <= 1; dx++) {
          if (dy == 0 && dx == 0) {
            continue;
          }
          if (map[(y + dy, x + dx)] == '@') {
            adj++;
          }
        }
      }
      if (adj < 4) {
        rolls++;
      }
    }
  }
  return rolls;
}

part2(data) {
  return 0;
}

void main() async {
  final input = await FileUtils.readFileAsString('src/04/input.txt');

  print('Day 04, part1: ${part1(input)}');
  print('Day 04, part2: ${part2(input)}');
}
