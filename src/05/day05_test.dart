import 'package:test/test.dart';
import 'day05.dart';

void main() {
  const ingredients = [
    '3-5',
    '10-14',
    '16-20',
    '12-18',
    '',
    '1',
    '5',
    '8',
    '11',
    '17',
    '32',
  ];

  group('Part1', () {
    test('sample', () {
      expect(part1(ingredients), equals(3));
    });
  });

  group('Part2', () {
    test('sample', () {
      expect(part2(ingredients), equals(14));
    });
  });
}
