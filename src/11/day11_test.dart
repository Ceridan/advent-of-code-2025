import 'package:test/test.dart';
import 'day11.dart';

void main() {
  const devices = [
    'aaa: you hhh',
    'you: bbb ccc',
    'bbb: ddd eee',
    'ccc: ddd eee fff',
    'ddd: ggg',
    'eee: out',
    'fff: out',
    'ggg: out',
    'hhh: ccc fff iii',
    'iii: out',
  ];
  group('Part1', () {
    test('sample', () {
      expect(part1(devices), equals(5));
    });
  });

  group('Part2', () {
    test('sample', () {
      expect(part2(devices), equals(0));
    });
  });
}
