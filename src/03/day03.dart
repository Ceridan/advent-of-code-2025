import '../lib/io.dart';

(int, int) findHighest(String bank, int startIdx, int size) {
  var idx = startIdx;
  var r = bank.codeUnitAt(startIdx);
  for (int i = startIdx + 1; i <= bank.length - size; i++) {
    var c = bank.codeUnitAt(i);
    if (r < c) {
      r = c;
      idx = i;
    }
  }
  return (r, idx);
}

int processBank(String bank, int numBatteries) {
  var zeroRune = '0'.codeUnitAt(0);
  var joltage = 0;
  var startIdx = 0;
  for (int i = numBatteries; i >= 1; i--) {
    var (r, idx) = findHighest(bank, startIdx, i);
    startIdx = idx + 1;
    joltage = joltage * 10 + (r - zeroRune);
  }
  return joltage;
}

int calculateJoltage(data, int numBatteries) {
  var joltage = 0;
  for (String bank in data) {
    joltage += processBank(bank, numBatteries);
  }
  return joltage;
}

part1(data) {
  return calculateJoltage(data, 2);
}

part2(data) {
  return calculateJoltage(data, 12);
}

void main() async {
  final input = await FileUtils.readFileAsLines('src/03/input.txt');

  print('Day 03, part1: ${part1(input)}');
  print('Day 03, part2: ${part2(input)}');
}
