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

int processInstructions(List<String> data,
    int Function(Instruction, int prevPos, int newPos) calcZeroesFn) {
  var instructions = Instruction.parseLines(data);
  var zeroes = 0;
  var pos = 50;
  instructions.forEach((instr) {
    var sign = instr.direction == 'L' ? -1 : 1;
    var newPos = ((pos + sign * instr.value) % 100);
    zeroes += calcZeroesFn(instr, pos, newPos);
    pos = newPos;
  });
  return zeroes;
}

part1(data) {
  var calcZeroesFn = (instr, prevPos, newPos) => newPos == 0 ? 1 : 0;
  return processInstructions(data, calcZeroesFn);
}

part2(data) {
  var calcZeroesFn = (Instruction instr, prevPos, newPos) {
    var zeroes = (instr.value ~/ 100).abs();
    return switch ((instr.direction, prevPos, newPos)) {
      (_, 0, _) => zeroes,
      ('L', int p, int n) when n > p || n == 0 => ++zeroes,
      ('R', int p, int n) when n < p => ++zeroes,
      _ => zeroes,
    };
  };
  return processInstructions(data, calcZeroesFn);
}

void main() async {
  final input = await FileUtils.readFileAsLines('src/01/input.txt');

  print('Day 01, part1: ${part1(input)}');
  print('Day 01, part2: ${part2(input)}');
}
