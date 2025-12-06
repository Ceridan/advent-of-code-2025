import 'package:test/test.dart';
import 'day06.dart';

void main() {
  const homework = '''
123 328  51 64
 45 64  387 23
  6 98  215 314
*   +   *   +  ''';

  group('Part1', () {
    test('sample', () {
      expect(part1(homework), equals(4277556));
    });
  });

  group('Part2', () {
    test('sample', () {
      expect(part2(homework), equals(3263827));
    });
  });
}
