class Point {
  final int x;
  final int y;

  const Point(this.x, this.y);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other.runtimeType != runtimeType) return false;

    final Point otherPoint = other as Point;
    return x == otherPoint.x && y == otherPoint.y;
  }

  @override
  int get hashCode {
    return Object.hash(x, y);
  }

  @override
  String toString() {
    return 'Point($x, $y)';
  }
}
