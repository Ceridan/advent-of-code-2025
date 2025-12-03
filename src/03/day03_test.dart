import 'package:test/test.dart';
import 'day03.dart';

void main() {
  const banks = [
    '987654321111111',
    '811111111111119',
    '234234234234278',
    '818181911112111'
  ];

  group('Part1', () {
    test('sample', () {
      expect(part1(banks), equals(357));
    });
  });

  group('Part2', () {
    test('sample', () {
      expect(part2(banks), equals(3121910778619));
    });
  });
}
