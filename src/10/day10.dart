import '../lib/io.dart';

part1(data) {
  return 0;
}

part2(data) {
  return 0;
}

void main() async {
  final input = await FileUtils.readFileAsString('src/10/input.txt');

  print('Day 10, part1: ${part1(input)}');
  print('Day 10, part2: ${part2(input)}');
}
