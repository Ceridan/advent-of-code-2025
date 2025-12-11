import 'package:test/test.dart';
import 'day11.dart';

void main() {
  group('Part1', () {
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

    test('sample', () {
      expect(part1(devices), equals(5));
    });
  });

  group('Part2', () {
    const devices = [
      'svr: aaa bbb',
      'aaa: fft',
      'fft: ccc',
      'bbb: tty',
      'tty: ccc',
      'ccc: ddd eee',
      'ddd: hub',
      'hub: fff',
      'eee: dac',
      'dac: fff',
      'fff: ggg hhh',
      'ggg: out',
      'hhh: out',
    ];

    test('sample', () {
      expect(part2(devices), equals(2));
    });
  });
}
