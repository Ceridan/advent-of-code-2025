import '../lib/io.dart';

class Instruction {
  final String direction;
  final int value;

  Instruction(this.direction, this.value);
}

_parseInstructions(List<String> input) {
  var instructions = [];
  input.forEach((line) {
    if (line.isEmpty) {
      return;
    }
    var dir = line.substring(0, 1);
    var val = int.parse(line.substring(1));
    instructions.add(Instruction(dir, val));
  });
  return instructions;
}

part1(data) {
  var instructions = _parseInstructions(data);
  var zeroes = 0;
  var pos = 50;
  instructions.forEach((instr) {
    var sign = instr.direction == 'L' ? -1 : 1;
    pos = ((pos + sign * instr.value) % 100) as int;
    if (pos == 0) {
      zeroes++;
    }
  });
  return zeroes;
}

part2(data) {
  return 0;
}

void main() async {
  final input = await FileUtils.readFileAsLines('src/01/input.txt');

  print('Day 01, part1: ${part1(input)}');
  print('Day 01, part2: ${part2(input)}');
}
