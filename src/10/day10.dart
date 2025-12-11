import 'dart:collection';
import '../lib/io.dart';
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

bool isEqualStates(List<bool> state1, List<bool> state2) {
  if (state1.length != state2.length) {
    return false;
  }

  for (int i = 0; i < state1.length; i++) {
    if (state1[i] != state2[i]) {
      return false;
    }
  }
  return true;
}

int calculatePressCount(Schema schema) {
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
    if (isEqualStates(schema.diagram, newState)) {
      return clicks + 1;
    }
    var key = newState.join(',');
    if (visited.contains(key)) {
      continue;
    }
    visited.add(key);
    schema.buttons.forEach((b) => queue.add((b, newState, clicks + 1)));
  }
  return -1;
}

List<int> solveWithZ3(Schema schema) {
  var buttonMatrix = <List<int>>[];
  for (int i = 0; i < schema.joltages.length; i++) {
    var buttonArr = <int>[];
    for (var button in schema.buttons) {
      var coeff = (button.contains(i) ? 1 : 0);
      buttonArr.add(coeff);
    }
    buttonMatrix.add(buttonArr);
  }

  var result = Z3Solver().solveLP(buttonMatrix, schema.joltages);

  if (result == null) {
    throw Exception(
        'No solution for buttons = ${schema.buttons} and joltages = ${schema.joltages}');
  }

  return result;
}

part1(data) {
  var schemas = (data as List<String>).map(Schema.fromString).toList();
  var totalPress = schemas.map(calculatePressCount).reduce((acc, p) => acc + p);
  return totalPress;
}

part2(data) {
  var schemas = (data as List<String>).map(Schema.fromString).toList();
  var totalPress = 0;
  for (var schema in schemas) {
    var result = solveWithZ3(schema);
    totalPress += result.reduce((acc, x) => acc + x);
  }
  return totalPress;
}

void main() async {
  final input = await FileUtils.readFileAsLines('src/10/input.txt');

  print('Day 10, part1: ${part1(input)}');
  print('Day 10, part2: ${part2(input)}');
}
