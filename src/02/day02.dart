import '../lib/io.dart';

class ProductIdRange {
  int left;
  int right;

  ProductIdRange(this.left, this.right);

  static List<ProductIdRange> parseIds(String ids) {
    var ranges = <ProductIdRange>[];
    ids.split(',').forEach((pair) {
      var [left, right] = pair.split('-');
      var range = ProductIdRange(int.parse(left), int.parse(right));
      ranges.add(range);
    });
    return ranges;
  }
}

int checkIdRange(ProductIdRange range) {
  var invalidSum = 0;
  for (int val = range.left; val <= range.right; val++) {
    var valStr = val.toString();
    if (valStr.length % 2 == 1) {
      continue;
    }

    var mid = valStr.length ~/ 2;
    var left = valStr.substring(0, mid);
    var right = valStr.substring(mid);

    if (left == right) {
      invalidSum += val;
    }
  }

  return invalidSum;
}

int checkIdRange2(ProductIdRange range) {
  var invalidSum = 0;
  for (int val = range.left; val <= range.right; val++) {
    var valStr = val.toString();
    outerLoop:
    for (int i = (valStr.length ~/ 2); i >= 1; i--) {
      if (valStr.length % i != 0) {
        continue;
      }
      for (int j = i; j < valStr.length; j += i) {
        if (valStr.substring(j - i, j) != valStr.substring(j, j + i)) {
          continue outerLoop;
        }
      }
      invalidSum += val;
      break outerLoop;
    }
  }

  return invalidSum;
}

part1(data) {
  var invalidSum = 0;
  var idRanges = ProductIdRange.parseIds(data);
  idRanges.forEach((range) {
    invalidSum += checkIdRange(range);
  });
  return invalidSum;
}

part2(data) {
  var invalidSum = 0;
  var idRanges = ProductIdRange.parseIds(data);
  idRanges.forEach((range) {
    invalidSum += checkIdRange2(range);
  });
  return invalidSum;
}

void main() async {
  final input = await FileUtils.readFileAsString('src/02/input.txt');

  print('Day 02, part1: ${part1(input)}');
  print('Day 02, part2: ${part2(input)}');
}
