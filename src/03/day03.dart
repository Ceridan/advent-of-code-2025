import '../lib/io.dart';

int processBank(String bank) {
  var zeroRune = '0'.codeUnitAt(0);
  var r1 = bank.codeUnitAt(0);
  var r2 = bank.codeUnitAt(1);
  for (int i = 1; i < bank.length; i++) {
    if (i < bank.length - 1 && bank.codeUnitAt(i) > r1) {
      r1 = bank.codeUnitAt(i);
      r2 = bank.codeUnitAt(i + 1);
    } else if (bank.codeUnitAt(i) > r2) {
      r2 = bank.codeUnitAt(i);
    }
  }
  var joltage = (r1 - zeroRune) * 10 + (r2 - zeroRune);
  print('joltage = $joltage, bank = $bank');
  return joltage;
}

part1(data) {
  var joltage = 0;
  for (String bank in data) {
    joltage += processBank(bank);
  }
  return joltage;
}

part2(data) {
  return 0;
}

void main() async {
  final input = await FileUtils.readFileAsLines('src/03/input.txt');

  print('Day 03, part1: ${part1(input)}');
  print('Day 03, part2: ${part2(input)}');
}

// 16852 is too low
