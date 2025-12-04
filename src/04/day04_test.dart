import 'package:test/test.dart';
import 'day04.dart';

void main() {
  const map = '''
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
''';

  group('Part1', () {
    test('sample', () {
      expect(part1(map), equals(13));
    });
  });

  group('Part2', () {
    test('sample', () {
      expect(part2(map), equals(43));
    });
  });
}
