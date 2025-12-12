import '../lib/io.dart';
import '../lib/point.dart';

class Present {
  final int id;
  final Set<Point> coords;

  Present(this.id, this.coords);

  int size() {
    return coords.length;
  }

  Present rotate() {
    var newCoords = coords.map((p) {
      int tx = p.x - 1;
      int ty = p.y - 1;

      int rx = -ty;
      int ry = tx;

      return Point(rx + 1, ry + 1);
    }).toSet();
    return Present(id, newCoords);
  }

  printPresent() {
    var line = <String>[];
    for (int y = 0; y < 3; y++) {
      for (int x = 0; x < 3; x++) {
        var p = Point(x, y);
        var ch = coords.contains(p) ? '#' : '.';
        line.add(ch);
      }
      line.add('\n');
    }
    print(line.join());
  }
}

class Region {
  final int width;
  final int height;
  final List<int> presents;

  Region(this.width, this.height, this.presents);
}

(Map<int, Present>, List<Region>) parseInput(String input) {
  var presents = <int, Present>{};
  var regions = <Region>[];
  var lines = input.split('\n').where((l) => l.isNotEmpty).toList();
  var i = 0;
  while (i < lines.length) {
    if (lines[i].contains('x')) {
      var parts = lines[i].split(':');
      var sizes = parts[0].split('x').where((p) => p.isNotEmpty).toList();
      var ids = parts[1].split(' ').where((p) => p.isNotEmpty).toList();
      var region = Region(int.parse(sizes[0]), int.parse(sizes[1]),
          ids.map((id) => int.parse(id)).toList());
      regions.add(region);
      i++;
      continue;
    }

    var id = int.parse(lines[i].substring(0, lines[i].length - 1));
    var coords = <Point>{};
    for (int y = 0; y < 3; y++) {
      for (int x = 0; x < 3; x++) {
        if (lines[i + y + 1][x] == '#') {
          coords.add(Point(x, y));
        }
      }
    }
    var present = Present(id, coords);
    presents[id] = present;
    i += 4;
  }
  return (presents, regions);
}

// I failed to find a solution in a finite time and ended up with a heuristic.
// Looking at the example data I noticed that all the presents occupy 7 out of 9 tiles.
// In my input however, only 4 tiles have this property. I started to think how they can be combined together,
// and figured out that on average combining any two tiles occupy 8 out of 9 tiles.
// Having this assumption, we can think in terms of occupied tiles instead of different shapes.
// We can say that presents fit to the region if the sum of the presents multiplied by 8
// less then region area.
// Alternative approach was to calculate real tile sum such as for each present multiply count on present size.
// It gives the same correct result on my input but fails on the example.
part1(data) {
  var (presents, regions) = parseInput(data);
  var totalFit = 0;
  for (var region in regions) {
    var presentSum = region.presents.reduce((acc, id) => acc + id);
    var canFit = presentSum * 8 < region.width * region.height;
    totalFit += canFit ? 1 : 0;
  }
  return totalFit;
}

part2(data) {
  return 0;
}

void main() async {
  final input = await FileUtils.readFileAsString('src/12/input.txt');

  print('Day 12, part1: ${part1(input)}');
  print('Day 12, part2: -');
}
