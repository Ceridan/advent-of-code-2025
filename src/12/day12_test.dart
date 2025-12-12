import 'package:test/test.dart';
import 'day12.dart';

void main() {
  const presents = '''
0:
###
##.
##.

1:
###
##.
.##

2:
.##
###
##.

3:
##.
###
##.

4:
###
#..
###

5:
###
.#.
###

4x4: 0 0 0 0 2 0
12x5: 1 0 1 0 2 2
12x5: 1 0 1 0 3 2
''';

  group('Part1', () {
    test('sample', () {
      expect(part1(presents), equals(2));
    });
  });

  group('Part2', () {
    test('sample', () {
      expect(part2(presents), equals(0));
    });
  });
}
