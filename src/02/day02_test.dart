import 'package:test/test.dart';
import 'day02.dart';

void main() {
  const productIdRanges =
      '11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124';

  group('Part1', () {
    test('sample', () {
      expect(part1(productIdRanges), equals(1227775554));
    });
  });

  group('Part2', () {
    test('sample', () {
      expect(part2(productIdRanges), equals(4174379265));
    });
  });
}
