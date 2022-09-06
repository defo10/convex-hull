// ignore_for_file: non_constant_identifier_names

import 'package:logging/logging.dart';

extension on List<Point2d> {
  Point2d get secondToLast => elementAt(length - 2);
}

class Point2d implements Comparable<Point2d> {
  final double x;
  final double y;

  const Point2d(this.x, this.y);

  Point2d sub(Point2d p) => Point2d(x - p.x, y - p.y);
  double cross(Point2d p) => x * p.y - y * p.x;

  @override
  int compareTo(Point2d other) =>
      ((x != other.x) ? x - other.x : y - other.y).round();

  @override
  String toString() => "($x;$y)";
}

enum Direction {
  clockwise,
  counterclockwise,
  collinear;

  /// returns the turn direction to go from line AB to o
  static Direction between(Point2d a, Point2d b, Point2d o) {
    final AB = b.sub(a);
    final BO = o.sub(b);
    final crossProduct = AB.cross(BO);
    if (crossProduct > 0) {
      return Direction.counterclockwise;
    } else if (crossProduct == 0) {
      return Direction.collinear;
    } else {
      return Direction.clockwise;
    }
  }
}

List<Point2d> convexHull(List<Point2d> points) {
  if (Set.from(points).length < 3) {
    Logger("ConvexHull").info("convexHull was called with less than 3 points.");
    return points;
  }

  final sortedPoints = List<Point2d>.from(points)..sort();

  final lowerHalf = _halfHull(sortedPoints);
  final upperHalf = _halfHull(sortedPoints.reversed);

  lowerHalf.removeLast();
  upperHalf.removeLast();
  return [...lowerHalf, ...upperHalf];
}

List<Point2d> _halfHull(Iterable<Point2d> points) {
  final halfHull = <Point2d>[];
  for (final point in points) {
    while (halfHull.length >= 2 &&
        Direction.between(halfHull.secondToLast, halfHull.last, point) !=
            Direction.counterclockwise) {
      halfHull.removeLast();
    }
    halfHull.add(point);
  }
  return halfHull;
}
