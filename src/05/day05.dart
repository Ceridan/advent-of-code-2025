import '../lib/io.dart';

(List<(int, int)>, List<int>) parseInput(List<String> input) {
  var available = <(int, int)>[];
  var ingredients = <int>[];
  for (var line in input) {
    if (line.isEmpty) {
      continue;
    }
    var arr = line.split('-');
    if (arr.length == 1) {
      ingredients.add(int.parse(arr[0]));
    } else {
      available.add((int.parse(arr[0]), int.parse(arr[1])));
    }
  }
  return (available, ingredients);
}

part1(data) {
  var (available, ingredients) = parseInput(data);
  var fresh = 0;
  for (var ingredient in ingredients) {
    for (var (a, b) in available) {
      if (a <= ingredient && b >= ingredient) {
        fresh++;
        break;
      }
    }
  }
  return fresh;
}

part2(data) {
  return 0;
}

void main() async {
  final input = await FileUtils.readFileAsLines('src/05/input.txt');

  print('Day 05, part1: ${part1(input)}');
  print('Day 05, part2: ${part2(input)}');
}
