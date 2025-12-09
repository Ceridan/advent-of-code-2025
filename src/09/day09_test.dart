import 'package:test/test.dart';
import 'day09.dart';

void main() {
  const tileMap = '''
7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3
''';

  group('Part1', () {
    test('sample', () {
      expect(part1(tileMap), equals(50));
    });
  });

  group('Part2', () {
    test('sample', () {
      expect(part2(tileMap), equals(24));
    });
  });
}
