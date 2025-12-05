import 'dart:math' as math;
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

int compareRange(a, b) {
  var (al, ar) = a;
  var (bl, br) = b;
  var left = al.compareTo(bl);
  if (left != 0) {
    return left;
  }
  return ar.compareTo(br);
}

List<(int, int)> mergeIngredients(List<(int, int)> available) {
  var merged = <(int, int)>[];
  var (al, ar) = available[0];
  for (var i = 1; i < available.length; i++) {
    var (bl, br) = available[i];
    if (ar < bl) {
      merged.add((al, ar));
      al = bl;
      ar = br;
      continue;
    }
    ar = math.max(ar, br);
  }
  merged.add((al, ar));
  return merged;
}

part1(data) {
  var (available, ingredients) = parseInput(data);
  available.sort(compareRange);
  var merged = mergeIngredients(available);
  var fresh = 0;
  for (var ingredient in ingredients) {
    for (var (a, b) in merged) {
      if (a <= ingredient && b >= ingredient) {
        fresh++;
        break;
      }
    }
  }
  return fresh;
}

part2(data) {
  var (available, _) = parseInput(data);
  available.sort(compareRange);
  var merged = mergeIngredients(available);
  var fresh = 0;
  for (var (a, b) in merged) {
    fresh += b - a + 1;
  }
  return fresh;
}

void main() async {
  final input = await FileUtils.readFileAsLines('src/05/input.txt');

  print('Day 05, part1: ${part1(input)}');
  print('Day 05, part2: ${part2(input)}');
}
