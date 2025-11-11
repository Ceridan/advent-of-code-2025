import '../lib/io.dart';

part1(data) {
  return 0;
}

part2(data) {
  return 0;
}

void main() async {
  final input = await FileUtils.readFileAsString('src/XX/input.txt');

  print('Day XX, part1: ${part1(input)}');
  print('Day XX, part2: ${part2(input)}');
}
