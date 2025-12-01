import '../lib/io.dart';

class Instruction {
  final String direction;
  final int value;

  Instruction(this.direction, this.value);

  static List<Instruction> parseLines(List<String> lines) {
    List<Instruction> instructions = [];
    lines.forEach((line) {
      if (line.isEmpty) {
        return;
      }
      var dir = line.substring(0, 1);
      var val = int.parse(line.substring(1));
      instructions.add(Instruction(dir, val));
    });
    return instructions;
  }
}

part1(data) {
  var instructions = Instruction.parseLines(data);
  var zeroes = 0;
  var pos = 50;
  instructions.forEach((instr) {
    var sign = instr.direction == 'L' ? -1 : 1;
    pos = ((pos + sign * instr.value) % 100);
    if (pos == 0) {
      zeroes++;
    }
  });
  return zeroes;
}

part2(data) {
  var instructions = Instruction.parseLines(data);
  var zeroes = 0;
  var pos = 50;
  instructions.forEach((instr) {
    var sign = instr.direction == 'L' ? -1 : 1;
    var newPos = ((pos + sign * instr.value) % 100);
    zeroes += (instr.value ~/ 100).abs();
    if (instr.direction == 'L' && pos != 0 && (newPos > pos || newPos == 0)) {
      zeroes++;
    }
    if (instr.direction == 'R' && pos != 0 && newPos < pos) {
      zeroes++;
    }
    pos = newPos;
  });
  return zeroes;
}

void main() async {
  final input = await FileUtils.readFileAsLines('src/01/input.txt');

  print('Day 01, part1: ${part1(input)}');
  print('Day 01, part2: ${part2(input)}');
}
