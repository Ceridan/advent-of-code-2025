import '../lib/io.dart';
import 'dart:collection';
import '../lib/z3.dart';

class Schema {
  final List<bool> diagram;
  final List<List<int>> buttons;
  final List<int> joltages;

  Schema(this.diagram, this.buttons, this.joltages);

  static Schema fromString(String input) {
    var diagram = <bool>[];
    var buttons = <List<int>>[];
    var joltages = <int>[];
    var sections = input.split(' ');
    for (var section in sections) {
      if (section[0] == '[') {
        for (int i = 1; i < section.length - 1; i++) {
          diagram.add(section[i] == '#');
        }
        continue;
      }
      if (section[0] == '(') {
        buttons.add([]);
      }
      var vals = section.substring(1, section.length - 1).split(',');
      for (var val in vals) {
        if (section[0] == '(') {
          buttons[buttons.length - 1].add(int.parse(val));
        } else {
          joltages.add(int.parse(val));
        }
      }
    }
    return Schema(diagram, buttons, joltages);
  }
}

String diagramString(List<bool> diagram) {
  return diagram.map((l) => l ? '#' : '.').join();
}

String joltagesString(List<int> joltages) {
  return joltages.join(',');
}

int checkState(List<int> ethalon, List<int> current) {
  for (int i = 0; i < ethalon.length; i++) {
    if (ethalon[i] > current[i]) {
      return 1;
    }
    if (ethalon[i] < current[i]) {
      return 2;
    }
  }
  return 0;
}

int calculateMinPress(Schema schema) {
  var ethalon = diagramString(schema.diagram);
  var emptyDiagram = List<bool>.filled(schema.diagram.length, false);
  var visited = <String>{};
  var states = schema.buttons.map((btn) => (btn, emptyDiagram, 0)).toList();
  var queue = Queue<(List<int>, List<bool>, int)>.from(states);
  while (queue.isNotEmpty) {
    var (btn, state, clicks) = queue.removeFirst();
    var newState = [...state];
    for (var b in btn) {
      newState[b] = !newState[b];
    }
    var stateStr = diagramString(newState);
    if (stateStr == ethalon) {
      return clicks + 1;
    }
    if (visited.contains(stateStr)) {
      continue;
    }
    visited.add(stateStr);
    schema.buttons.forEach((b) => queue.add((b, newState, clicks + 1)));
  }
  return -1;
}

List<int> solveWithZ3(List<List<int>> buttons, List<int> target) {
  var buttonMatrix = <List<int>>[];
  for (int i = 0; i < target.length; i++) {
    var buttonArr = <int>[];
    for (var button in buttons) {
      var coeff = (button.contains(i) ? 1 : 0);
      buttonArr.add(coeff);
    }
    buttonMatrix.add(buttonArr);
  }

  var result = Z3Solver().solveLP(buttonMatrix, target);

  if (result == null) {
    throw Exception('No solution for target = $target');
  }

  return result;
}

part1(data) {
  var schemas = (data as List<String>).map(Schema.fromString).toList();
  var totalPress = schemas.map(calculateMinPress).reduce((acc, p) => acc + p);
  return totalPress;
}

part2(data) {
  var schemas = (data as List<String>).map(Schema.fromString).toList();
  var totalPress = 0;
  for (var schema in schemas) {
    var result = solveWithZ3(schema.buttons, schema.joltages);
    totalPress += result.reduce((acc, x) => acc + x);
  }
  return totalPress;
}

void main() async {
  final input = await FileUtils.readFileAsLines('src/10/input.txt');

  print('Day 10, part1: ${part1(input)}');
  print('Day 10, part2: ${part2(input)}');
}
