import 'package:test/test.dart';
import 'day01.dart';

void main() {
  const instructions = [
    "L68",
    "L30",
    "R48",
    "L5",
    "R60",
    "L55",
    "L1",
    "L99",
    "R14",
    "L82",
  ];

  group('Part1', () {
    test('sample', () {
      expect(part1(instructions), equals(3));
    });
  });
  group('Part2', () {
    test('sample', () {
      expect(part2("test"), equals(0));
    });
  });
}
