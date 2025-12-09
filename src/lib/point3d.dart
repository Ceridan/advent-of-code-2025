import 'dart:math' as math;

class Point3D {
  final int x;
  final int y;
  final int z;

  const Point3D(this.x, this.y, this.z);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other.runtimeType != runtimeType) return false;

    final Point3D otherPoint = other as Point3D;
    return x == otherPoint.x && y == otherPoint.y && z == otherPoint.z;
  }

  @override
  int get hashCode {
    return Object.hash(x, y, z);
  }

  @override
  String toString() {
    return 'Point3D($x, $y, $z)';
  }

  double distance(Point3D otherPoint) {
    var dx = math.pow(x - otherPoint.x, 2);
    var dy = math.pow(y - otherPoint.y, 2);
    var dz = math.pow(z - otherPoint.z, 2);
    return math.sqrt(dx + dy + dz);
  }
}
